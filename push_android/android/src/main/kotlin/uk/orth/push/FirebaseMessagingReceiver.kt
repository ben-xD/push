package uk.orth.push

import android.app.ActivityManager
import android.app.ActivityManager.RunningAppProcessInfo
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import uk.orth.push.PushHostHandlers.Companion.ON_BACKGROUND_MESSAGE_PROCESSING_COMPLETE

class FirebaseMessagingReceiver : BroadcastReceiver() {
    private var asyncProcessingPendingResult: PendingResult? = null
    private var flutterBackgroundMessageProcessingCompleteReceiver: FlutterBackgroundMessageProcessingCompleteReceiver? = null
    override fun onReceive(context: Context, intent: Intent) {
        listenForFlutterApplicationToFinishProcessingMessage(context)
        sendMessageToFlutterApplication(context, intent)
    }

    /**
     * Launches a broadcast receiver ([FlutterBackgroundMessageProcessingCompleteReceiver]) so that the
     * enclosing receiver (FirebaseMessagingReceiver), can be informed when the Flutter application
     * completes. The Flutter application also has a receiver
     * (PushMessagingEventHandlers.BroadcastReceiver) to listen to messages from this receiver
     * (FirebaseMessagingReceiver).
     */
    private fun listenForFlutterApplicationToFinishProcessingMessage(context: Context) {
        // Wait for Flutter application to process message
        // At the end of the receiver's execution time (and user's application processing the message)
        // , Firebase messaging library will automatically create a notification.
        // On iOS, the notification may be shown before the  message is processed by the application.
        // goAsync() also increases the execution time from 10s/ 20s (depending on API level) to 30s
        if (flutterBackgroundMessageProcessingCompleteReceiver == null) {
            flutterBackgroundMessageProcessingCompleteReceiver = FlutterBackgroundMessageProcessingCompleteReceiver(context)
            asyncProcessingPendingResult = goAsync()
        }
    }

    private fun sendMessageToFlutterApplication(
            context: Context, intent: Intent) {
        val isApplicationInForeground = isApplicationInForeground(context)
        when {
            isApplicationInForeground -> {
                PushHostHandlers.sendMessageToFlutterApp(context, intent)
            }
            PushPlugin.isMainActivityRunning -> {
                PushHostHandlers.sendBackgroundMessageToFlutterApp(context, intent)
            }
            else -> {
                BackgroundFlutterAppLauncher(context, this, intent)
            }
        }
    }

    private fun isApplicationInForeground(context: Context): Boolean {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        // This only shows processes for the current android app.
        val appProcesses = activityManager.runningAppProcesses
                ?: // If no processes are running, appProcesses are null, not an empty list.
                // The user's app is definitely not in the foreground if no processes are running.
                return false
        for (process in appProcesses) {
            // Importance is IMPORTANCE_SERVICE (not IMPORTANCE_FOREGROUND)
            //  - when app was terminated, or
            //  - when app is in the background, or
            //  - when screen is locked, including when app was in foreground.
            if (process.importance == RunningAppProcessInfo.IMPORTANCE_FOREGROUND) {
                // App is in the foreground
                return true
            }
        }
        return false
    }

    /**
     * A dynamic broadcast receiver registered to listen to a
     * `PUSH_ON_BACKGROUND_MESSAGE_PROCESSING_COMPLETE`
     */
    internal inner class FlutterBackgroundMessageProcessingCompleteReceiver(context: Context?) : BroadcastReceiver() {
        init {
            val filter = IntentFilter()
            filter.addAction(ON_BACKGROUND_MESSAGE_PROCESSING_COMPLETE)
            LocalBroadcastManager.getInstance(context!!).registerReceiver(this, filter)
        }

        override fun onReceive(context: Context, intent: Intent) {
            flutterBackgroundMessageProcessingCompleteReceiver?.let {
                LocalBroadcastManager.getInstance(context).unregisterReceiver(it)
                flutterBackgroundMessageProcessingCompleteReceiver = null
            }
            if (intent.action == ON_BACKGROUND_MESSAGE_PROCESSING_COMPLETE) {
                finish()
            } else {
                Log.e(TAG, String.format("Received unknown intent action: %s", intent.action))
            }
        }
    }

    fun finish() {
        asyncProcessingPendingResult?.finish()
        asyncProcessingPendingResult = null
    }

    companion object {
        private val TAG = FirebaseMessagingReceiver::class.qualifiedName
    }
}
