package uk.orth.push

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.google.firebase.messaging.RemoteMessage
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import uk.orth.push.serialization.PushApi
import uk.orth.push.serialization.toPushRemoteMessage

class PushPlugin : FlutterPlugin, ActivityAware, PluginRegistry.NewIntentListener {
    private var pushHostHandlers: PushHostHandlers? = null
    private var mainActivity: Activity? = null
    private var applicationContext: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val binaryMessenger = flutterPluginBinding.binaryMessenger
        applicationContext = flutterPluginBinding.applicationContext
        pushHostHandlers = PushHostHandlers.getInstance(applicationContext!!, binaryMessenger)
        PushApi.PushHostApi.setup(binaryMessenger, pushHostHandlers)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        // TODO how do i undo/close resources done initialized in PushApi.PushHostApi.setup
        // I could modify the code generated file to try to do clean up, and e.g. then call this.
//        PushApi.PushHostApi.setup(null, null)
        pushHostHandlers!!.close(applicationContext!!)
        pushHostHandlers = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Log.v(TAG, "ActivityAware#onAttachedToActivity called")
        isMainActivityRunning = true
        val mainActivity = binding.activity
        this.mainActivity = mainActivity
        binding.addOnNewIntentListener(this)
        handleRemoteMessageIntent(
                mainActivity.intent
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
        binding.addOnNewIntentListener(this);
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
                intent
        ) { message ->
            // Application already running when notification is tapped
            pushHostHandlers?.onNotificationTap(message)
        }
        return false
    }

    private fun handleRemoteMessageIntent(intent: Intent, callback: (message: RemoteMessage) -> Unit) {
        intent.extras ?: return
        val message = RemoteMessage(intent.extras!!)
        // Notification is always empty here, even if the RemoteMessage originally had a notification.
        if (message.data.isNotEmpty()) {
            callback(message)
        }
    }

    companion object {
        private val TAG = PushPlugin::class.qualifiedName
        internal var isMainActivityRunning = false

        // If implementing your own FirebaseMessagingService, be sure to call PushPlugin.onNewToken
        // in your FirebaseMessagingService#onNewToken override.
        fun onNewToken(context: Context, fcmRegistrationToken: String) {
            // Send intent so running application can get it.
            PushHostHandlers.onNewToken(context, fcmRegistrationToken)
        }
    }
}
