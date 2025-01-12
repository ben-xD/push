// Autogenerated from Pigeon (v22.7.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")

package uk.orth.push.serialization

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMethodCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is FlutterError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): FlutterError {
  return FlutterError("channel-error",  "Unable to establish connection on channel: '$channelName'.", "")}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/**
 * # iOS UN (UserNotification) symbols
 *
 * Dart/Flutter translation of the iOS permissions API. In a future release,
 * we may replace this API with a consistent API for all platforms that require
 * permissions to show notifications to the user.
 * UNAuthorizationStatus: Constants indicating whether the app is allowed to
 * schedule notifications.
 *
 * See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsettings/1648391-authorizationstatus) for more information
 */
enum class UNAuthorizationStatus(val raw: Int) {
  NOT_DETERMINED(0),
  DENIED(1),
  AUTHORIZED(2),
  PROVISIONAL(3),
  EPHEMERAL(4);

  companion object {
    fun ofRaw(raw: Int): UNAuthorizationStatus? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * The type of notification the user will see
 *
 * See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unalertstyle) for more information
 */
enum class UNAlertStyle(val raw: Int) {
  NONE(0),
  BANNER(1),
  ALERT(2);

  companion object {
    fun ofRaw(raw: Int): UNAlertStyle? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * The current configuration of a notification setting
 *
 * See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsetting) for more information
 */
enum class UNNotificationSetting(val raw: Int) {
  NOT_SUPPORTED(0),
  DISABLED(1),
  ENABLED(2);

  companion object {
    fun ofRaw(raw: Int): UNNotificationSetting? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * Conditions to show/reveal notification content to the user
 *
 * See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unshowpreviewssetting) for more information
 */
enum class UNShowPreviewsSetting(val raw: Int) {
  ALWAYS(0),
  WHEN_AUTHENTICATED(1),
  NEVER(2);

  companion object {
    fun ofRaw(raw: Int): UNShowPreviewsSetting? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class RemoteMessage (
  val notification: Notification? = null,
  val data: Map<String?, Any?>? = null
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): RemoteMessage {
      val notification = pigeonVar_list[0] as Notification?
      val data = pigeonVar_list[1] as Map<String?, Any?>?
      return RemoteMessage(notification, data)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      notification,
      data,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class Notification (
  val title: String? = null,
  val body: String? = null
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): Notification {
      val title = pigeonVar_list[0] as String?
      val body = pigeonVar_list[1] as String?
      return Notification(title, body)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      title,
      body,
    )
  }
}

/**
 * The object for reading notification-related settings and the authorization status of your app.
 *
 * See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsettings) for more information
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class UNNotificationSettings (
  val authorizationStatus: UNAuthorizationStatus? = null,
  val soundSetting: UNNotificationSetting? = null,
  val badgeSetting: UNNotificationSetting? = null,
  val alertSetting: UNNotificationSetting? = null,
  val notificationCenterSetting: UNNotificationSetting? = null,
  val lockScreenSetting: UNNotificationSetting? = null,
  val carPlaySetting: UNNotificationSetting? = null,
  val alertStyle: UNAlertStyle? = null,
  val showPreviewsSetting: UNShowPreviewsSetting? = null,
  val criticalAlertSetting: UNNotificationSetting? = null,
  val providesAppNotificationSettings: Boolean? = null,
  val announcementSetting: UNNotificationSetting? = null
)
 {
  companion object {
    fun fromList(pigeonVar_list: List<Any?>): UNNotificationSettings {
      val authorizationStatus = pigeonVar_list[0] as UNAuthorizationStatus?
      val soundSetting = pigeonVar_list[1] as UNNotificationSetting?
      val badgeSetting = pigeonVar_list[2] as UNNotificationSetting?
      val alertSetting = pigeonVar_list[3] as UNNotificationSetting?
      val notificationCenterSetting = pigeonVar_list[4] as UNNotificationSetting?
      val lockScreenSetting = pigeonVar_list[5] as UNNotificationSetting?
      val carPlaySetting = pigeonVar_list[6] as UNNotificationSetting?
      val alertStyle = pigeonVar_list[7] as UNAlertStyle?
      val showPreviewsSetting = pigeonVar_list[8] as UNShowPreviewsSetting?
      val criticalAlertSetting = pigeonVar_list[9] as UNNotificationSetting?
      val providesAppNotificationSettings = pigeonVar_list[10] as Boolean?
      val announcementSetting = pigeonVar_list[11] as UNNotificationSetting?
      return UNNotificationSettings(authorizationStatus, soundSetting, badgeSetting, alertSetting, notificationCenterSetting, lockScreenSetting, carPlaySetting, alertStyle, showPreviewsSetting, criticalAlertSetting, providesAppNotificationSettings, announcementSetting)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      authorizationStatus,
      soundSetting,
      badgeSetting,
      alertSetting,
      notificationCenterSetting,
      lockScreenSetting,
      carPlaySetting,
      alertStyle,
      showPreviewsSetting,
      criticalAlertSetting,
      providesAppNotificationSettings,
      announcementSetting,
    )
  }
}
private open class PushApiPigeonCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      129.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          UNAuthorizationStatus.ofRaw(it.toInt())
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          UNAlertStyle.ofRaw(it.toInt())
        }
      }
      131.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          UNNotificationSetting.ofRaw(it.toInt())
        }
      }
      132.toByte() -> {
        return (readValue(buffer) as Long?)?.let {
          UNShowPreviewsSetting.ofRaw(it.toInt())
        }
      }
      133.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          RemoteMessage.fromList(it)
        }
      }
      134.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Notification.fromList(it)
        }
      }
      135.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          UNNotificationSettings.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is UNAuthorizationStatus -> {
        stream.write(129)
        writeValue(stream, value.raw)
      }
      is UNAlertStyle -> {
        stream.write(130)
        writeValue(stream, value.raw)
      }
      is UNNotificationSetting -> {
        stream.write(131)
        writeValue(stream, value.raw)
      }
      is UNShowPreviewsSetting -> {
        stream.write(132)
        writeValue(stream, value.raw)
      }
      is RemoteMessage -> {
        stream.write(133)
        writeValue(stream, value.toList())
      }
      is Notification -> {
        stream.write(134)
        writeValue(stream, value.toList())
      }
      is UNNotificationSettings -> {
        stream.write(135)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}


/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface PushHostApi {
  /**
   * Returns null if it doesn't exist.
   * See [PushFlutterApi.onNotificationTap] to understand why a RemoteMessage is not provided here.
   */
  fun getNotificationTapWhichLaunchedTerminatedApp(): Map<String?, Any?>?
  fun getToken(callback: (Result<String>) -> Unit)
  /**
   * Android only
   * Delete the token. You'll get a new one immediately on [PushFlutterApi.onNewToken].
   *
   * The old token would be invalid, and trying to send a FCM message to it
   *  will get an error: `Requested entity was not found.`
   */
  fun deleteToken(callback: (Result<Unit>) -> Unit)
  /**
   * iOS only
   * Registration is done automatically when the application starts.
   * This is only useful if you previously called [PushHostApi.unregisterForRemoteNotifications].
   * You'll get the next token from [PushFlutterApi.onNewToken]. Unfortunately, this would most likely be
   * the same token as before you called [PushHostApi.unregisterForRemoteNotifications].
   */
  fun registerForRemoteNotifications()
  /**
   * iOS only
   * Temporary disable receiving push notifications until next app restart. You can re-enable immediately with [PushHostApi.registerForRemoteNotifications].
   * This might be useful if you're logging someone out or you want to completely disable all notifications.
   * Trying to send an APNs message to the token will fail, until `registerForRemoteNotifications` is called.
   * For iOS details, see https://developer.apple.com/documentation/uikit/uiapplication/1623093-unregisterforremotenotifications
   * Warning: on IOS simulators, no notifications will be delivered when calling unregisterForRemoteNotifications and then `registerForRemoteNotifications`
   */
  fun unregisterForRemoteNotifications()
  fun backgroundFlutterApplicationReady()
  /**
   * Pass true for the option you want permission to use
   * Returns true if permission was granted.
   */
  fun requestPermission(badge: Boolean, sound: Boolean, alert: Boolean, carPlay: Boolean, criticalAlert: Boolean, provisional: Boolean, providesAppNotificationSettings: Boolean, announcement: Boolean, callback: (Result<Boolean>) -> Unit)
  fun getNotificationSettings(callback: (Result<UNNotificationSettings>) -> Unit)
  fun areNotificationsEnabled(callback: (Result<Boolean>) -> Unit)

  companion object {
    /** The codec used by PushHostApi. */
    val codec: MessageCodec<Any?> by lazy {
      PushApiPigeonCodec()
    }
    /** Sets up an instance of `PushHostApi` to handle messages through the `binaryMessenger`. */
    @JvmOverloads
    fun setUp(binaryMessenger: BinaryMessenger, api: PushHostApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.getNotificationTapWhichLaunchedTerminatedApp$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              listOf(api.getNotificationTapWhichLaunchedTerminatedApp())
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.getToken$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.getToken{ result: Result<String> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.deleteToken$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.deleteToken{ result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.registerForRemoteNotifications$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              api.registerForRemoteNotifications()
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.unregisterForRemoteNotifications$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              api.unregisterForRemoteNotifications()
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.backgroundFlutterApplicationReady$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              api.backgroundFlutterApplicationReady()
              listOf(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.requestPermission$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val badgeArg = args[0] as Boolean
            val soundArg = args[1] as Boolean
            val alertArg = args[2] as Boolean
            val carPlayArg = args[3] as Boolean
            val criticalAlertArg = args[4] as Boolean
            val provisionalArg = args[5] as Boolean
            val providesAppNotificationSettingsArg = args[6] as Boolean
            val announcementArg = args[7] as Boolean
            api.requestPermission(badgeArg, soundArg, alertArg, carPlayArg, criticalAlertArg, provisionalArg, providesAppNotificationSettingsArg, announcementArg) { result: Result<Boolean> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.getNotificationSettings$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.getNotificationSettings{ result: Result<UNNotificationSettings> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.push.PushHostApi.areNotificationsEnabled$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.areNotificationsEnabled{ result: Result<Boolean> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
class PushFlutterApi(private val binaryMessenger: BinaryMessenger, private val messageChannelSuffix: String = "") {
  companion object {
    /** The codec used by PushFlutterApi. */
    val codec: MessageCodec<Any?> by lazy {
      PushApiPigeonCodec()
    }
  }
  fun onMessage(messageArg: RemoteMessage, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.push.PushFlutterApi.onMessage$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(messageArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onBackgroundMessage(messageArg: RemoteMessage, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.push.PushFlutterApi.onBackgroundMessage$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(messageArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  /**
   * Unfortunately, the intent provided to the app when a user taps on a
   * notification does not include notification's title or body.
   * In this instance, it makes more sense to remove this useful functionality from iOS too.
   * Only the data property on the RemoteMessage is returned to the user.
   * This is effectively the lowest common denominator API.
   *
   * Hint: You can still include the title, body or other metadata in your
   * data payload to identify what notification the user tapped on.
   */
  fun onNotificationTap(dataArg: Map<String?, Any?>, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.push.PushFlutterApi.onNotificationTap$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(dataArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onNewToken(tokenArg: String, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.push.PushFlutterApi.onNewToken$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(tokenArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
  fun onOpenNotificationSettings(callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.push.PushFlutterApi.onOpenNotificationSettings$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(null) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
}
