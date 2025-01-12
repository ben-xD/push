package uk.orth.push.serialization

import com.google.firebase.messaging.RemoteMessage as FcmRemoteMessage

fun FcmRemoteMessage.toMap(): Map<String, Any?> =
    mapOf<String, Any?>(
        "data" to data,
        "notification" to notification?.toMap(),
    )

fun FcmRemoteMessage.Notification.toMap(): Map<String, Any?> =
    mapOf(
        "title" to this.title,
        "body" to this.body,
    )

fun FcmRemoteMessage.Notification.toPushNotification(): Notification = Notification(this.title, this.body)

fun FcmRemoteMessage.toPushRemoteMessage(): RemoteMessage = RemoteMessage(this.notification?.toPushNotification(), this.data.toMap())
