package uk.orth.push

import android.content.Context
import android.content.Intent
import com.google.firebase.messaging.RemoteMessage
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import uk.orth.push.serialization.toMap
import kotlin.collections.ArrayList
import kotlin.collections.HashMap

/**
 * Intents received when the application is tapped do not include the notification (e.g. title, body)
 * so we save it here. We can retrieve the fully-sized original message when a notification is tapped,
 * and provide the user with this RemoteMessage instead of using the intent from the tap.
 *
 * A majority of this file was adapted from the Java code in Firebase Messaging,
 * taken from https://github.com/firebase/flutterfire/blob/master/packages/firebase_messaging/firebase_messaging/android/src/main/java/io/flutter/plugins/firebase/messaging/FlutterFirebaseMessagingStore.java.
 *
 * The issue with this implementation is that it stores messages until the notification is tapped.
 * A notification may never be tapped, so it will stay in the list forever.
 *
 * Can we empty the notification list on every tap? No, because the user could tap older notifications.
 * I store 50 notifications since the maximum notifications an app can display at a time is
 * `MAX_PACKAGE_NOTIFICATIONS`, which is set to 50 https://github.com/aosp-mirror/platform_frameworks_base/blob/7db3ab2c8614e6a64865b9fd0ce3f8c91f588154/services/core/java/com/android/server/notification/NotificationManagerService.java#L347
 */
class RemoteMessageStoreForNotificationTaps {

    fun storeMessageForLaterNotificationTap(context: Context, intent: Intent) {
        val sharedPreferences = context.getSharedPreferences(SHARED_PREFERENCES_NAME, Context.MODE_PRIVATE)
        val remoteMessage = RemoteMessage(intent.extras!!)
        val remoteMessageString: String = JSONObject(remoteMessage.toMap()).toString()
        sharedPreferences.edit().apply {
            putString(remoteMessage.messageId, remoteMessageString)
            apply()
        }

        // Save new notification id.
        // Note that this is using a comma delimited string to preserve ordering. We could use a String Set
        // on SharedPreferences but this won't guarantee ordering when we want to remove the oldest added ids.
        var notificationIdsString = sharedPreferences.getString(KEY_NOTIFICATION_IDS, "")!!
        notificationIdsString += remoteMessage.messageId + DELIMITER; // append to last

        // Check and remove old notification messages.
        val allNotificationList = notificationIdsString.split(DELIMITER)
        if (allNotificationList.size > MAX_SIZE_NOTIFICATIONS) {
            val firstRemoteMessageId = allNotificationList[0]
            sharedPreferences.edit().apply {
                remove(firstRemoteMessageId)
                apply()
            }
            notificationIdsString = notificationIdsString.replace(firstRemoteMessageId + DELIMITER, "")
        }

        sharedPreferences.edit().apply {
            putString(KEY_NOTIFICATION_IDS, notificationIdsString)
            apply()
        }
    }

    fun getMessageForNotificationTap(context: Context, remoteMessageId: String): RemoteMessage? {
        val sharedPreferences = context.getSharedPreferences(SHARED_PREFERENCES_NAME, Context.MODE_PRIVATE)
        val remoteMessageString = sharedPreferences.getString(remoteMessageId, null)
        remoteMessageString?.let {
            try {
                val remoteMessageMap = jsonObjectToMap(JSONObject(remoteMessageString))
                // Add a fake 'to' - as it's required to construct a RemoteMessage instance.
                deleteRemoteMessage(context, remoteMessageId)
                // In the Fluttefire code, FlutterFirebaseMessagingUtils.getRemoteMessageForArguments
                // is called.
                return remoteMessageFromMap(remoteMessageMap)
            } catch (e: JSONException) {
                e.printStackTrace()
            }
        }
        return null
    }

    private fun remoteMessageFromMap(message: Map<String, Any>): RemoteMessage {
        @Suppress("UNCHECKED_CAST")
        // TODO Use the below if remoteMessageMap is nested in a another map. Return RemoteMessage?
//        val message = remoteMessageMap["message"] as? Map<String, Any> ?: return null
        val to = message.get("to") as String
        val builder = RemoteMessage.Builder(to)

        @Suppress("UNCHECKED_CAST")
        message["data"]?.let {builder.setData(it as Map<String, String>)}
        message["collapseKey"]?.let { builder.setCollapseKey(it as String) }
        message["messageId"]?.let { builder.setMessageId(it as String) }
        message["messageType"]?.let { builder.setMessageType(it as String) }
        message["ttl"]?.let { builder.setTtl(it as Int) }
        return builder.build()
    }


    private fun deleteRemoteMessage(context: Context, remoteMessageId: String) {
        val sharedPreferences = context.getSharedPreferences(SHARED_PREFERENCES_NAME, Context.MODE_PRIVATE)
        sharedPreferences.edit().apply {
            remove(remoteMessageId)
            var notifications = sharedPreferences.getString(KEY_NOTIFICATION_IDS, "")!!
            if (notifications.isNotEmpty()) {
                notifications = notifications.replace(remoteMessageId + DELIMITER, "")
                putString(KEY_NOTIFICATION_IDS, notifications)
            }
            apply()
        }
    }

    private fun jsonObjectToMap(jsonObject: JSONObject): MutableMap<String, Any> {
        val map: MutableMap<String, Any> = HashMap()
        val keys = jsonObject.keys()
        while (keys.hasNext()) {
            val key = keys.next()
            var value = jsonObject[key]
            if (value is JSONArray) {
                value = jsonArrayToList(value)
            } else if (value is JSONObject) {
                value = jsonObjectToMap(value)
            }
            map[key] = value
        }
        return map
    }

    private fun jsonArrayToList(array: JSONArray): List<Any> {
        val list: MutableList<Any> = ArrayList()
        for (i in 0 until array.length()) {
            var value: Any = array.get(i)
            if (value is JSONArray) {
                value = jsonArrayToList(value)
            } else if (value is JSONObject) {
                value = jsonObjectToMap(value)
            }
            list.add(value)
        }
        return list
    }

    companion object {
        val instance = RemoteMessageStoreForNotificationTaps()
        private const val KEY_NOTIFICATION_IDS = "NOTIFICATION_IDS_KEY"
        private const val SHARED_PREFERENCES_NAME = "RemoteMessageStore"
        private const val DELIMITER = ","
        private const val MAX_SIZE_NOTIFICATIONS = 20
    }
}