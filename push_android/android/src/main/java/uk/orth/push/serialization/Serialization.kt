package uk.orth.push.serialization

import com.google.firebase.messaging.RemoteMessage

fun RemoteMessage.toMap(): Map<String, Any?> {
    return mapOf<String, Any?>(
            "data" to data,
            "notification" to notification?.toMap()
    )
}

fun RemoteMessage.Notification.toMap(): Map<String, Any?> {
    return mapOf(
            "title" to this.title,
            "body" to this.body
    )
}

fun RemoteMessage.Notification.toPushNotification(): PushApi.Notification {
    this.let {
        val pushNotification = PushApi.Notification()
        pushNotification.title = it.title
        pushNotification.body = it.body
        return pushNotification
    }
}

fun RemoteMessage.toPushRemoteMessage(): PushApi.RemoteMessage {
    val message = PushApi.RemoteMessage()
    message.data = this.data.toMap()
    message.notification = this.notification?.toPushNotification()
    return message
}
