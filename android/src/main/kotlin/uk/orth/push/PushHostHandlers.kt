package uk.orth.push

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import androidx.core.app.NotificationManagerCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.RemoteMessage
import io.flutter.plugin.common.BinaryMessenger
import uk.orth.push.serialization.PushFlutterApi
import uk.orth.push.serialization.PushHostApi
import uk.orth.push.serialization.UNNotificationSettings
import uk.orth.push.serialization.toPushRemoteMessage

/**
 * The implementation of [PushHostApi], handling messages called from the Flutter application.
 */
class PushHostHandlers(
    context: Context,
    binaryMessenger: BinaryMessenger,
    private val onRequestPushNotificationsPermission: ((callback: (Result<Boolean>) -> Unit) -> Unit)? = null,
) : PushHostApi {
    var notificationTapPayloadWhichLaunchedApp: Map<String?, Any?>? = null
    private var context: Context? = context
    private var pushFlutterApi = PushFlutterApi(binaryMessenger)
    private var broadcastReceiver = BroadcastReceiver(context)

    private var appTerminatedRemoteMessage: RemoteMessage? = null
    private var remoteMessageProcessingComplete: (() -> Unit)? = null

    fun setupForBackgroundNotificationProcessing(
        appTerminatedRemoteMessage: RemoteMessage? = null,
        remoteMessageProcessingComplete: (() -> Unit)? = null,
    ) {
        this.appTerminatedRemoteMessage = appTerminatedRemoteMessage
        this.remoteMessageProcessingComplete = remoteMessageProcessingComplete
    }

    fun close() {
        broadcastReceiver.close(context)
        context = null
    }

    override fun getNotificationTapWhichLaunchedTerminatedApp(): Map<String?, Any?>? = notificationTapPayloadWhichLaunchedApp

    override fun getToken(callback: (Result<String>) -> Unit) {
        FirebaseMessaging.getInstance().token.addOnCompleteListener(
            OnCompleteListener { task ->
                if (!task.isSuccessful) {
                    Log.w(TAG, "Fetching FCM registration token failed", task.exception)
                    callback(
                        Result.failure(
                            IllegalStateException(
                                "Fetching FCM registration token failed, but exception was null",
                                task.exception,
                            ),
                        ),
                    )
                    return@OnCompleteListener
                } else {
                    val fcmToken = task.result
                    if (fcmToken == null) {
                        Log.w(TAG, "FCM token was null")
                        callback(Result.failure(IllegalStateException("FCM token was null")))
                        return@OnCompleteListener
                    }
                    // Return latest FCM registration token
                    callback(Result.success(fcmToken))
                }
            },
        )
    }

    override fun deleteToken(callback: (Result<Unit>) -> Unit) {
        FirebaseMessaging.getInstance().deleteToken().addOnCompleteListener(
            OnCompleteListener { task ->
                if (!task.isSuccessful) {
                    Log.w(TAG, "Deleting FCM registration token failed", task.exception)
                    callback(
                        Result.failure(
                            IllegalStateException(
                                "Deleting FCM registration token failed",
                                task.exception,
                            ),
                        ),
                    )
                    return@OnCompleteListener
                }
                callback(Result.success(Unit))
            },
        )
    }

    override fun registerForRemoteNotifications() {}

    override fun unregisterForRemoteNotifications() {}

    override fun backgroundFlutterApplicationReady() {
        appTerminatedRemoteMessage?.let { message ->
            // This signals that the manually spawned app is ready to receive a message to handle.
            // We ask the user to set the background message handler early on.
            pushFlutterApi.onBackgroundMessage(message.toPushRemoteMessage()) { result ->
                if (result.isSuccess) remoteMessageProcessingComplete!!.invoke()
                if (result.isFailure) println("backgroundFlutterApplicationReady error: ${result.exceptionOrNull()}")
            }
        } ?: run {
            Log.v(
                TAG,
                "Ignoring this method because it is used in a separate listener " +
                    "(`BackgroundFlutterAppLauncher.kt`), when the Flutter app is launched manually.",
            )
        }
    }

    private var fcmRegistrationToken: String? = null

    override fun requestPermission(
        badge: Boolean,
        sound: Boolean,
        alert: Boolean,
        carPlay: Boolean,
        criticalAlert: Boolean,
        provisional: Boolean,
        providesAppNotificationSettings: Boolean,
        announcement: Boolean,
        callback: (Result<Boolean>) -> Unit,
    ) {
        // We use this let ?: run structure so kotlin understands onRequestPushNotificationsPermission was not mutated to be null later
        onRequestPushNotificationsPermission?.let {
            it(callback)
        } ?: run {
            callback(
                Result.failure(
                    IllegalAccessException(
                        "requestPermission was called but there was no activity. This should only be called when the user has the app in the foreground.",
                    ),
                ),
            )
        }
    }

    override fun getNotificationSettings(callback: (Result<UNNotificationSettings>) -> Unit) {
        callback(Result.failure(NoSuchMethodException("getNotificationSettings is not supported on Android")))
    }

    override fun areNotificationsEnabled(callback: (Result<Boolean>) -> Unit) {
        val areNotificationsEnabled =
            NotificationManagerCompat.from(context!!).areNotificationsEnabled()
        callback(Result.success(areNotificationsEnabled))
    }

    fun onNewToken(fcmRegistrationToken: String) {
        this.fcmRegistrationToken = fcmRegistrationToken
        pushFlutterApi.onNewToken(fcmRegistrationToken) { _ -> }
    }

    fun onNotificationTap(message: RemoteMessage) {
        pushFlutterApi.onNotificationTap(
            message.toPushRemoteMessage().data ?: emptyMap(),
        ) { _ -> }
    }

    companion object {
        private val TAG = PushHostHandlers::class.qualifiedName
        const val ON_MESSAGE_RECEIVED = "uk.orth.push.PUSH_ON_MESSAGE_RECEIVED"
        const val ON_BACKGROUND_MESSAGE_RECEIVED =
            "uk.orth.push.PUSH_ON_BACKGROUND_MESSAGE_RECEIVED"
        const val ON_BACKGROUND_MESSAGE_PROCESSING_COMPLETE =
            "uk.orth.push.PUSH_ON_BACKGROUND_MESSAGE_COMPLETE"
        const val ON_NEW_TOKEN = "uk.orth.push.ON_NEW_TOKEN"
        const val TOKEN = "uk.orth.push.TOKEN"

        @SuppressLint("StaticFieldLeak") // We clean up when we call close.
        private var instance: PushHostHandlers? = null

        @Synchronized
        fun getInstance(
            context: Context,
            binaryMessenger: BinaryMessenger,
            onRequestPushNotificationsPermission: ((callback: (Result<Boolean>) -> Unit) -> Unit)? = null,
        ): PushHostHandlers =
            instance
                ?: PushHostHandlers(context, binaryMessenger, onRequestPushNotificationsPermission)

        // Send message to Dart side app already running
        fun sendMessageToFlutterApp(
            context: Context,
            intent: Intent,
        ) {
            val onMessageReceivedIntent = Intent(ON_MESSAGE_RECEIVED)
            onMessageReceivedIntent.putExtras(intent.extras!!)
            LocalBroadcastManager.getInstance(context).sendBroadcast(onMessageReceivedIntent)
        }

        // Flutter is already running, just send a background message to it.
        fun sendBackgroundMessageToFlutterApp(
            context: Context,
            intent: Intent,
        ) {
            val onMessageReceivedIntent = Intent(ON_BACKGROUND_MESSAGE_RECEIVED)
            onMessageReceivedIntent.putExtras(intent.extras!!)
            LocalBroadcastManager.getInstance(context).sendBroadcast(onMessageReceivedIntent)
        }

        fun onNewToken(
            context: Context,
            token: String,
        ) {
            val onMessageReceivedIntent = Intent(ON_NEW_TOKEN)
            onMessageReceivedIntent.putExtra(TOKEN, token)
            LocalBroadcastManager.getInstance(context).sendBroadcast(onMessageReceivedIntent)
        }
    }

    private inner class BroadcastReceiver(
        context: Context,
    ) : android.content.BroadcastReceiver() {
        init {
            register(context)
        }

        fun register(context: Context) {
            val filter = IntentFilter()
            filter.addAction(ON_MESSAGE_RECEIVED)
            filter.addAction(ON_BACKGROUND_MESSAGE_RECEIVED)
            filter.addAction(ON_NEW_TOKEN)
            LocalBroadcastManager.getInstance(context).registerReceiver(this, filter)
        }

        fun close(context: Context?) {
            LocalBroadcastManager.getInstance(context!!).unregisterReceiver(this)
        }

        override fun onReceive(
            context: Context,
            intent: Intent,
        ) {
            when (val action = intent.action) {
                ON_MESSAGE_RECEIVED -> {
                    val message = RemoteMessage(intent.extras!!).toPushRemoteMessage()
                    pushFlutterApi.onMessage(message) { _ -> finish(context) }
                }

                ON_BACKGROUND_MESSAGE_RECEIVED -> {
                    val message = RemoteMessage(intent.extras!!).toPushRemoteMessage()
                    pushFlutterApi.onBackgroundMessage(message) { _ -> finish(context) }
                }

                ON_NEW_TOKEN -> {
                    val fcmRegistrationToken = intent.getStringExtra(TOKEN)!!
                    onNewToken(fcmRegistrationToken)
                }

                else -> Log.e(TAG, String.format("Received unknown intent action: %s", action))
            }
        }

        fun finish(context: Context?) {
            val backgroundMessageCompleteIntent = Intent(ON_BACKGROUND_MESSAGE_PROCESSING_COMPLETE)
            LocalBroadcastManager
                .getInstance(context!!)
                .sendBroadcast(backgroundMessageCompleteIntent)
        }
    }
}
