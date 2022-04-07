package uk.orth.push.serialization

import com.google.firebase.messaging.RemoteMessage

fun RemoteMessage.toMap(): Map<String, Any?> {
    val notificationMap: Map<String, Any?> = notification?.toMap()
    //     Workaround because null crashes the app during serialization
            ?: return mapOf<String, Any?>(
                    "data" to data,
                    "notification" to mapOf(
                            "title" to "",
                            "body" to ""
                    )
            )

    return mapOf<String, Any?>(
            "data" to data,
            "notification" to notificationMap,
    )
}

fun RemoteMessage.Notification.toMap(): Map<String, Any?> {
    return mapOf(
            "title" to this.title,
            "body" to this.body
    )
}

fun RemoteMessage.toPushRemoteMessage(): PushApi.RemoteMessage {
    return PushApi.RemoteMessage.fromMap(this.toMap())
}