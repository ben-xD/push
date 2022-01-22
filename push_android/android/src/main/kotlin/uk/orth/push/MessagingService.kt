package uk.orth.push

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

// We listen to the message using a broadcast receiver (`FirebaseMessagingReceiver`)
// instead of this/ a service because multiple broadcast listeners can be called
// in response to an intent filter, but only 1 activity/ service can be called. This means
// we won't conflict with other packages/ plugins and will be more reliable.
// See `android:permission` on `<receiver>`
// [docs](https://developer.android.com/guide/topics/manifest/receiver-element#prmsn) for more
// information.
class MessagingService: FirebaseMessagingService() {
    override fun onNewToken(registrationToken: String) {
        super.onNewToken(registrationToken)
        PushPlugin.onNewToken(this, registrationToken)
    }

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        // This class does not do anything in onMessageReceived, since [FirebaseMessagingReceiver]
        // listens to `com.google.android.c2dm.intent.RECEIVE` declared in the manifest.
    }
}