package uk.orth.push

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.core.app.NotificationManagerCompat
import com.google.firebase.messaging.RemoteMessage
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import uk.orth.push.serialization.PushHostApi
import uk.orth.push.serialization.toPushRemoteMessage

class PushPlugin :
    FlutterPlugin,
    ActivityAware,
    PluginRegistry.NewIntentListener,
    PluginRegistry.RequestPermissionsResultListener {
    private var pushHostHandlers: PushHostHandlers? = null
    private var mainActivity: Activity? = null
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val binaryMessenger = flutterPluginBinding.binaryMessenger
        applicationContext = flutterPluginBinding.applicationContext
        pushHostHandlers = PushHostHandlers.getInstance(applicationContext!!, binaryMessenger, ::onRequestPushNotificationsPermission)
        PushHostApi.setUp(binaryMessenger, pushHostHandlers)
    }

    private var isPushNotificationsPermissionPending = false
    private var requestPermissionsResultCallback: ((Result<Boolean>) -> Unit)? = null

    private fun onRequestPushNotificationsPermission(callback: (Result<Boolean>) -> Unit) {
        // if already granted, skip and return successful immediately. Log something though.
        val areNotificationsEnabled = NotificationManagerCompat.from(applicationContext!!).areNotificationsEnabled()
        if (areNotificationsEnabled) {
            Log.i(TAG, "onRequestPushNotificationsPermission: Notifications are already enabled")
            callback(Result.success(true))
            return
        }

        requestPermissionsResultCallback?.invoke(
            Result.failure(IllegalAccessException("requestPermission was already running. Only call this function once.")),
        )
        requestPermissionsResultCallback = callback
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            mainActivity?.requestPermissions(
                arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                POST_NOTIFICATION_REQUEST_CODE,
            )
            isPushNotificationsPermissionPending = true
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        // TODO how do i undo/close resources done initialized in PushApi.PushHostApi.setup
        // I could modify the code generated file to try to do clean up, and e.g. then call this.
//        PushApi.PushHostApi.setup(null, null)
        pushHostHandlers!!.close()
        pushHostHandlers = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Log.v(TAG, "ActivityAware#onAttachedToActivity called")
        isMainActivityRunning = true
        val mainActivity = binding.activity
        this.mainActivity = mainActivity
        binding.addOnNewIntentListener(this)
        binding.addRequestPermissionsResultListener(this)
        handleRemoteMessageIntent(
            mainActivity.intent,
        ) { message ->
            // Notification caused an app to launched
            // Only saving the map because title/body are not provided in the RemoteMessage
            pushHostHandlers?.notificationTapPayloadWhichLaunchedApp = message.toPushRemoteMessage().data
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.v(TAG, "ActivityAware#onDetachedFromActivityForConfigChanges called")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.v(TAG, "ActivityAware#onReattachedToActivityForConfigChanges called")
        mainActivity = binding.activity
        binding.addOnNewIntentListener(this)
        binding.addRequestPermissionsResultListener(this)
    }

    // This method gets called when an Activity is detached from the FlutterEngine, either when
    // 1. when a different Activity is being attached to the FlutterEngine, or 2. the Activity is
    // being destroyed. It does not get called when the app goes into the background.
    override fun onDetachedFromActivity() {
        Log.v(TAG, "ActivityAware#onDetachedFromActivity called")
        mainActivity = null
        isMainActivityRunning = false
    }

    override fun onNewIntent(intent: Intent): Boolean {
        if (mainActivity != null) {
            mainActivity!!.intent = intent
        }
        handleRemoteMessageIntent(
            intent,
        ) { message ->
            // Application already running when notification is tapped
            pushHostHandlers?.onNotificationTap(message)
        }
        return false
    }

    private fun handleRemoteMessageIntent(
        intent: Intent,
        callback: (message: RemoteMessage) -> Unit,
    ) {
        intent.extras ?: return
        val message = RemoteMessage(intent.extras!!)
        // Notification is always empty here, even if the RemoteMessage originally had a notification.
        if (message.data.isNotEmpty()) {
            callback(message)
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ): Boolean {
        if (requestCode == POST_NOTIFICATION_REQUEST_CODE) {
            if (requestPermissionsResultCallback == null) {
                Log.w(
                    TAG,
                    "Developer error. onRequestPermissionsResult called with POST_NOTIFICATION_REQUEST_CODE but requestPermissionsResult is null",
                )
                // Not handled by this plugin
                return false
            }
            val granted = grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED
            requestPermissionsResultCallback?.invoke(Result.success(granted))
            requestPermissionsResultCallback = null
            isPushNotificationsPermissionPending = false
            // Handled by this plugin
            return true
        }
        // Not handled by this plugin
        return false
    }

    companion object {
        private val TAG = PushPlugin::class.qualifiedName
        internal var isMainActivityRunning = false

        // If implementing your own FirebaseMessagingService, be sure to call PushPlugin.onNewToken
        // in your FirebaseMessagingService#onNewToken override.
        fun onNewToken(
            context: Context,
            fcmRegistrationToken: String,
        ) {
            // Send intent so running application can get it.
            PushHostHandlers.onNewToken(context, fcmRegistrationToken)
        }

        // An arbitrary number
        private const val POST_NOTIFICATION_REQUEST_CODE = 8
    }
}
