// Autogenerated from Pigeon (v22.7.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Any?

  init(code: String, message: String?, details: Any?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
      }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func createConnectionError(withChannelName channelName: String) -> PigeonError {
  return PigeonError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// # iOS UN (UserNotification) symbols
///
/// Dart/Flutter translation of the iOS permissions API. In a future release,
/// we may replace this API with a consistent API for all platforms that require
/// permissions to show notifications to the user.
/// UNAuthorizationStatus: Constants indicating whether the app is allowed to
/// schedule notifications.
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsettings/1648391-authorizationstatus) for more information
enum UNAuthorizationStatus: Int {
  case notDetermined = 0
  case denied = 1
  case authorized = 2
  case provisional = 3
  case ephemeral = 4
}

/// The type of notification the user will see
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unalertstyle) for more information
enum UNAlertStyle: Int {
  case none = 0
  case banner = 1
  case alert = 2
}

/// The current configuration of a notification setting
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsetting) for more information
enum UNNotificationSetting: Int {
  case notSupported = 0
  case disabled = 1
  case enabled = 2
}

/// Conditions to show/reveal notification content to the user
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unshowpreviewssetting) for more information
enum UNShowPreviewsSetting: Int {
  case always = 0
  case whenAuthenticated = 1
  case never = 2
}

/// Generated class from Pigeon that represents data sent in messages.
struct RemoteMessage {
  var notification: Notification? = nil
  var data: [String?: Any?]? = nil


  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> RemoteMessage? {
    let notification: Notification? = nilOrValue(pigeonVar_list[0])
    let data: [String?: Any?]? = nilOrValue(pigeonVar_list[1])

    return RemoteMessage(
      notification: notification,
      data: data
    )
  }
  func toList() -> [Any?] {
    return [
      notification,
      data,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct Notification {
  var title: String? = nil
  var body: String? = nil


  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> Notification? {
    let title: String? = nilOrValue(pigeonVar_list[0])
    let body: String? = nilOrValue(pigeonVar_list[1])

    return Notification(
      title: title,
      body: body
    )
  }
  func toList() -> [Any?] {
    return [
      title,
      body,
    ]
  }
}

/// The object for reading notification-related settings and the authorization status of your app.
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsettings) for more information
///
/// Generated class from Pigeon that represents data sent in messages.
struct UNNotificationSettings {
  var authorizationStatus: UNAuthorizationStatus? = nil
  var soundSetting: UNNotificationSetting? = nil
  var badgeSetting: UNNotificationSetting? = nil
  var alertSetting: UNNotificationSetting? = nil
  var notificationCenterSetting: UNNotificationSetting? = nil
  var lockScreenSetting: UNNotificationSetting? = nil
  var carPlaySetting: UNNotificationSetting? = nil
  var alertStyle: UNAlertStyle? = nil
  var showPreviewsSetting: UNShowPreviewsSetting? = nil
  var criticalAlertSetting: UNNotificationSetting? = nil
  var providesAppNotificationSettings: Bool? = nil
  var announcementSetting: UNNotificationSetting? = nil


  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> UNNotificationSettings? {
    let authorizationStatus: UNAuthorizationStatus? = nilOrValue(pigeonVar_list[0])
    let soundSetting: UNNotificationSetting? = nilOrValue(pigeonVar_list[1])
    let badgeSetting: UNNotificationSetting? = nilOrValue(pigeonVar_list[2])
    let alertSetting: UNNotificationSetting? = nilOrValue(pigeonVar_list[3])
    let notificationCenterSetting: UNNotificationSetting? = nilOrValue(pigeonVar_list[4])
    let lockScreenSetting: UNNotificationSetting? = nilOrValue(pigeonVar_list[5])
    let carPlaySetting: UNNotificationSetting? = nilOrValue(pigeonVar_list[6])
    let alertStyle: UNAlertStyle? = nilOrValue(pigeonVar_list[7])
    let showPreviewsSetting: UNShowPreviewsSetting? = nilOrValue(pigeonVar_list[8])
    let criticalAlertSetting: UNNotificationSetting? = nilOrValue(pigeonVar_list[9])
    let providesAppNotificationSettings: Bool? = nilOrValue(pigeonVar_list[10])
    let announcementSetting: UNNotificationSetting? = nilOrValue(pigeonVar_list[11])

    return UNNotificationSettings(
      authorizationStatus: authorizationStatus,
      soundSetting: soundSetting,
      badgeSetting: badgeSetting,
      alertSetting: alertSetting,
      notificationCenterSetting: notificationCenterSetting,
      lockScreenSetting: lockScreenSetting,
      carPlaySetting: carPlaySetting,
      alertStyle: alertStyle,
      showPreviewsSetting: showPreviewsSetting,
      criticalAlertSetting: criticalAlertSetting,
      providesAppNotificationSettings: providesAppNotificationSettings,
      announcementSetting: announcementSetting
    )
  }
  func toList() -> [Any?] {
    return [
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
    ]
  }
}

private class PushApiPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return UNAuthorizationStatus(rawValue: enumResultAsInt)
      }
      return nil
    case 130:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return UNAlertStyle(rawValue: enumResultAsInt)
      }
      return nil
    case 131:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return UNNotificationSetting(rawValue: enumResultAsInt)
      }
      return nil
    case 132:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return UNShowPreviewsSetting(rawValue: enumResultAsInt)
      }
      return nil
    case 133:
      return RemoteMessage.fromList(self.readValue() as! [Any?])
    case 134:
      return Notification.fromList(self.readValue() as! [Any?])
    case 135:
      return UNNotificationSettings.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class PushApiPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? UNAuthorizationStatus {
      super.writeByte(129)
      super.writeValue(value.rawValue)
    } else if let value = value as? UNAlertStyle {
      super.writeByte(130)
      super.writeValue(value.rawValue)
    } else if let value = value as? UNNotificationSetting {
      super.writeByte(131)
      super.writeValue(value.rawValue)
    } else if let value = value as? UNShowPreviewsSetting {
      super.writeByte(132)
      super.writeValue(value.rawValue)
    } else if let value = value as? RemoteMessage {
      super.writeByte(133)
      super.writeValue(value.toList())
    } else if let value = value as? Notification {
      super.writeByte(134)
      super.writeValue(value.toList())
    } else if let value = value as? UNNotificationSettings {
      super.writeByte(135)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class PushApiPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return PushApiPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return PushApiPigeonCodecWriter(data: data)
  }
}

class PushApiPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = PushApiPigeonCodec(readerWriter: PushApiPigeonCodecReaderWriter())
}


/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol PushHostApi {
  /// Returns null if it doesn't exist.
  /// See [PushFlutterApi.onNotificationTap] to understand why a RemoteMessage is not provided here.
  func getNotificationTapWhichLaunchedTerminatedApp() throws -> [String?: Any?]?
  func getToken(completion: @escaping (Result<String, Error>) -> Void)
  /// Android only
  /// Delete the token. You'll get a new one immediately on [PushFlutterApi.onNewToken].
  ///
  /// The old token would be invalid, and trying to send a FCM message to it
  ///  will get an error: `Requested entity was not found.`
  func deleteToken(completion: @escaping (Result<Void, Error>) -> Void)
  /// iOS only
  /// Temporary disable receiving push notifications until next app restart. You can re-enable immediately with [PushHostApi.registerForRemoteNotifications].
  /// This might be useful if you're logging someone out or you want to completely disable all notifications.
  /// Trying to send an APNs message to the token will fail, until `registerForRemoteNotifications` is called.
  /// For iOS details, see https://developer.apple.com/documentation/uikit/uiapplication/1623093-unregisterforremotenotifications
  /// Warning: on IOS simulators, no notifications will be delivered when calling unregisterForRemoteNotifications and then `registerForRemoteNotifications`
  func unregisterForRemoteNotifications() throws
  /// iOS only
  /// Registration is done automatically when the application starts.
  /// This is only useful if you previously called [PushHostApi.unregisterForRemoteNotifications].
  /// You'll get the next token from [PushFlutterApi.onNewToken]. Unfortunately, this would most likely be
  /// the same token as before you called [PushHostApi.unregisterForRemoteNotifications].
  func registerForRemoteNotifications() throws
  func backgroundFlutterApplicationReady() throws
  /// Pass true for the option you want permission to use
  /// Returns true if permission was granted.
  func requestPermission(badge: Bool, sound: Bool, alert: Bool, carPlay: Bool, criticalAlert: Bool, provisional: Bool, providesAppNotificationSettings: Bool, announcement: Bool, completion: @escaping (Result<Bool, Error>) -> Void)
  func getNotificationSettings(completion: @escaping (Result<UNNotificationSettings, Error>) -> Void)
  func areNotificationsEnabled(completion: @escaping (Result<Bool, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class PushHostApiSetup {
  static var codec: FlutterStandardMessageCodec { PushApiPigeonCodec.shared }
  /// Sets up an instance of `PushHostApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: PushHostApi?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    /// Returns null if it doesn't exist.
    /// See [PushFlutterApi.onNotificationTap] to understand why a RemoteMessage is not provided here.
    let getNotificationTapWhichLaunchedTerminatedAppChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.getNotificationTapWhichLaunchedTerminatedApp\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getNotificationTapWhichLaunchedTerminatedAppChannel.setMessageHandler { _, reply in
        do {
          let result = try api.getNotificationTapWhichLaunchedTerminatedApp()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getNotificationTapWhichLaunchedTerminatedAppChannel.setMessageHandler(nil)
    }
    let getTokenChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.getToken\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getTokenChannel.setMessageHandler { _, reply in
        api.getToken { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      getTokenChannel.setMessageHandler(nil)
    }
    /// Android only
    /// Delete the token. You'll get a new one immediately on [PushFlutterApi.onNewToken].
    ///
    /// The old token would be invalid, and trying to send a FCM message to it
    ///  will get an error: `Requested entity was not found.`
    let deleteTokenChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.deleteToken\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      deleteTokenChannel.setMessageHandler { _, reply in
        api.deleteToken { result in
          switch result {
          case .success:
            reply(wrapResult(nil))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      deleteTokenChannel.setMessageHandler(nil)
    }
    /// iOS only
    /// Temporary disable receiving push notifications until next app restart. You can re-enable immediately with [PushHostApi.registerForRemoteNotifications].
    /// This might be useful if you're logging someone out or you want to completely disable all notifications.
    /// Trying to send an APNs message to the token will fail, until `registerForRemoteNotifications` is called.
    /// For iOS details, see https://developer.apple.com/documentation/uikit/uiapplication/1623093-unregisterforremotenotifications
    /// Warning: on IOS simulators, no notifications will be delivered when calling unregisterForRemoteNotifications and then `registerForRemoteNotifications`
    let unregisterForRemoteNotificationsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.unregisterForRemoteNotifications\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      unregisterForRemoteNotificationsChannel.setMessageHandler { _, reply in
        do {
          try api.unregisterForRemoteNotifications()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      unregisterForRemoteNotificationsChannel.setMessageHandler(nil)
    }
    /// iOS only
    /// Registration is done automatically when the application starts.
    /// This is only useful if you previously called [PushHostApi.unregisterForRemoteNotifications].
    /// You'll get the next token from [PushFlutterApi.onNewToken]. Unfortunately, this would most likely be
    /// the same token as before you called [PushHostApi.unregisterForRemoteNotifications].
    let registerForRemoteNotificationsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.registerForRemoteNotifications\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      registerForRemoteNotificationsChannel.setMessageHandler { _, reply in
        do {
          try api.registerForRemoteNotifications()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      registerForRemoteNotificationsChannel.setMessageHandler(nil)
    }
    let backgroundFlutterApplicationReadyChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.backgroundFlutterApplicationReady\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      backgroundFlutterApplicationReadyChannel.setMessageHandler { _, reply in
        do {
          try api.backgroundFlutterApplicationReady()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      backgroundFlutterApplicationReadyChannel.setMessageHandler(nil)
    }
    /// Pass true for the option you want permission to use
    /// Returns true if permission was granted.
    let requestPermissionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.requestPermission\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      requestPermissionChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let badgeArg = args[0] as! Bool
        let soundArg = args[1] as! Bool
        let alertArg = args[2] as! Bool
        let carPlayArg = args[3] as! Bool
        let criticalAlertArg = args[4] as! Bool
        let provisionalArg = args[5] as! Bool
        let providesAppNotificationSettingsArg = args[6] as! Bool
        let announcementArg = args[7] as! Bool
        api.requestPermission(badge: badgeArg, sound: soundArg, alert: alertArg, carPlay: carPlayArg, criticalAlert: criticalAlertArg, provisional: provisionalArg, providesAppNotificationSettings: providesAppNotificationSettingsArg, announcement: announcementArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      requestPermissionChannel.setMessageHandler(nil)
    }
    let getNotificationSettingsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.getNotificationSettings\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getNotificationSettingsChannel.setMessageHandler { _, reply in
        api.getNotificationSettings { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      getNotificationSettingsChannel.setMessageHandler(nil)
    }
    let areNotificationsEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.push.PushHostApi.areNotificationsEnabled\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      areNotificationsEnabledChannel.setMessageHandler { _, reply in
        api.areNotificationsEnabled { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      areNotificationsEnabledChannel.setMessageHandler(nil)
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol PushFlutterApiProtocol {
  func onMessage(message messageArg: RemoteMessage, completion: @escaping (Result<Void, PigeonError>) -> Void)
  func onBackgroundMessage(message messageArg: RemoteMessage, completion: @escaping (Result<Void, PigeonError>) -> Void)
  /// Unfortunately, the intent provided to the app when a user taps on a
  /// notification does not include notification's title or body.
  /// In this instance, it makes more sense to remove this useful functionality from iOS too.
  /// Only the data property on the RemoteMessage is returned to the user.
  /// This is effectively the lowest common denominator API.
  ///
  /// Hint: You can still include the title, body or other metadata in your
  /// data payload to identify what notification the user tapped on.
  func onNotificationTap(data dataArg: [String?: Any?], completion: @escaping (Result<Void, PigeonError>) -> Void)
  func onNewToken(token tokenArg: String, completion: @escaping (Result<Void, PigeonError>) -> Void)
  func onOpenNotificationSettings(completion: @escaping (Result<Void, PigeonError>) -> Void)
}
class PushFlutterApi: PushFlutterApiProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  private let messageChannelSuffix: String
  init(binaryMessenger: FlutterBinaryMessenger, messageChannelSuffix: String = "") {
    self.binaryMessenger = binaryMessenger
    self.messageChannelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
  }
  var codec: PushApiPigeonCodec {
    return PushApiPigeonCodec.shared
  }
  func onMessage(message messageArg: RemoteMessage, completion: @escaping (Result<Void, PigeonError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.push.PushFlutterApi.onMessage\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([messageArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onBackgroundMessage(message messageArg: RemoteMessage, completion: @escaping (Result<Void, PigeonError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.push.PushFlutterApi.onBackgroundMessage\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([messageArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  /// Unfortunately, the intent provided to the app when a user taps on a
  /// notification does not include notification's title or body.
  /// In this instance, it makes more sense to remove this useful functionality from iOS too.
  /// Only the data property on the RemoteMessage is returned to the user.
  /// This is effectively the lowest common denominator API.
  ///
  /// Hint: You can still include the title, body or other metadata in your
  /// data payload to identify what notification the user tapped on.
  func onNotificationTap(data dataArg: [String?: Any?], completion: @escaping (Result<Void, PigeonError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.push.PushFlutterApi.onNotificationTap\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([dataArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onNewToken(token tokenArg: String, completion: @escaping (Result<Void, PigeonError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.push.PushFlutterApi.onNewToken\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([tokenArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onOpenNotificationSettings(completion: @escaping (Result<Void, PigeonError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.push.PushFlutterApi.onOpenNotificationSettings\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage(nil) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
