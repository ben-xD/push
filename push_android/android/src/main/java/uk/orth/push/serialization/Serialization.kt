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

fun RemoteMessage.toPushRemoteMessage(): PushApi.RemoteMessage {
    val message = PushApi.RemoteMessage()
    message.data = this.toMap()
    return message
}