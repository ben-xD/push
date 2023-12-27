package uk.orth.push

import android.content.Context
import android.content.Intent
import android.util.Log
import com.google.firebase.messaging.RemoteMessage
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import uk.orth.push.serialization.PushApi

/**
 * This class is used when the application was terminated when the push notification is received. It
 * launches the Flutter application and sends it a RemoteMessage. See
 * [PushHostHandlers] to see where push notifications being handled whilst the app is
 * in the background or the foreground. Use this class when no existing Flutter Activity is running.
 *
 * This class can be generalized to launch the app manually for any purpose, but currently it is
 * narrowly scoped for push notifications.
 *
 * Creates a Flutter engine, launches the Flutter application inside that Flutter engine, and
 * creates a MethodChannel to communicate with the Flutter application.
 *
 * @param context
 * @param broadcastReceiver The FirebaseMessagingReceiver which received the message
 * @param intent An intent containing a RemoteMessage passed straight from
 * FirebaseMessagingReceiver
 */
class BackgroundFlutterAppLauncher(
        context: Context,
        private val broadcastReceiver: FirebaseMessagingReceiver,
        intent: Intent) {

    private val remoteMessage: RemoteMessage = RemoteMessage((intent.extras)!!)
    private val flutterEngine: FlutterEngine = FlutterEngine(context, null)
    private var pushHostHandlers: PushHostHandlers = PushHostHandlers(context, flutterEngine.dartExecutor.binaryMessenger)

    init {
        // Setup listener for background processing
        pushHostHandlers.setupForBackgroundNotificationProcessing(remoteMessage) {finish()}
        // Setup listener
        PushApi.PushHostApi.setUp(flutterEngine.dartExecutor.binaryMessenger, pushHostHandlers)
        // Launch the users app isolate manually
        flutterEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        // Even though lifecycle parameter is @NonNull, the implementation
        // `FlutterEngineConnectionRegistry`
        // does not use it, because it is a bug in the API design. See
        // https://github.com/flutter/flutter/issues/90316
//         flutterEngine.broadcastReceiverControlSurface.attachToBroadcastReceiver(broadcastReceiver, null)
    }

    private fun finish() {
//        flutterEngine.broadcastReceiverControlSurface.detachFromBroadcastReceiver()
        Log.i(TAG, "Manually launched Flutter application has finished processing message. " +
                "Destroying FlutterEngine and finishing asynchronous Broadcast Receiver")
        flutterEngine.destroy()
        broadcastReceiver.finish()
    }

    companion object {
        private val TAG = BackgroundFlutterAppLauncher::class.qualifiedName
    }
}
