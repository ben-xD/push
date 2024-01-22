import 'package:pigeon/pigeon.dart';

// Regenerate the output files with `./scripts/codegen.sh`
@ConfigurePigeon(PigeonOptions(
  dartOut: '../push_platform_interface/lib/src/serialization/push_api.dart',
  dartTestOut: '../push_platform_interface/test/push_api_test.dart',
  // for iOS (not macOS, because Pigeon only supports 1 output path per language)
  objcHeaderOut: '../push_ios/ios/Classes/serialization/PushApi.h',
  objcSourceOut: '../push_ios/ios/Classes/serialization/PushApi.m',
  objcOptions: ObjcOptions(prefix: "PU"),
  // swiftOptions: SwiftOptions(),
  // swiftOut: '../push_ios/ios/Classes/serialization/PushApi.swift',
  kotlinOptions: KotlinOptions(package: 'uk.orth.push.serialization'),
  kotlinOut:
      '../push_android/android/src/main/kotlin/uk/orth/push/serialization/PushApi.kt',
))
// End of configuration

class RemoteMessage {
  Notification? notification;
  Map<String?, Object?>? data;
}

class Notification {
  String? title;
  String? body;
}

@HostApi()
abstract class PushHostApi {
  /// Returns null if it doesn't exist.
  /// See [PushFlutterApi.onNotificationTap] to understand why a RemoteMessage is not provided here.
  Map<String?, Object?>? getNotificationTapWhichLaunchedTerminatedApp();

  @async
  String getToken();

  /// Android only
  /// Delete the token. You'll get a new one immediately on [PushFlutterApi.onNewToken].
  ///
  /// The old token would be invalid, and trying to send a FCM message to it
  ///  will get an error: `Requested entity was not found.`
  @async
  void deleteToken();

  /// iOS only
  /// Temporary disable receiving push notifications until next app restart. You can re-enable immediately with [PushHostApi.registerForRemoteNotifications].
  /// This might be useful if you're logging someone out or you want to completely disable all notifications.
  /// Trying to send an APNs message to the token will fail, until `registerForRemoteNotifications` is called.
  /// For iOS details, see https://developer.apple.com/documentation/uikit/uiapplication/1623093-unregisterforremotenotifications
  /// Warning: on IOS simulators, no notifications will be delivered when calling unregisterForRemoteNotifications and then `registerForRemoteNotifications`
  void unregisterForRemoteNotifications();

  /// iOS only
  /// Registration is done automatically when the application starts.
  /// This is only useful if you previously called [PushHostApi.unregisterForRemoteNotifications].
  /// You'll get the next token from [PushFlutterApi.onNewToken]. Unfortunately, this would most likely be
  /// the same token as before you called [PushHostApi.unregisterForRemoteNotifications].
  void registerForRemoteNotifications();

  void backgroundFlutterApplicationReady();

  /// Pass true for the option you want permission to use
  /// Returns true if permission was granted.
  @async
  bool requestPermission(
    bool badge,
    bool sound,
    bool alert,
    bool carPlay,
    bool criticalAlert,
    bool provisional,
    bool providesAppNotificationSettings,
    bool announcement,
  );

  // iOS only
  @async
  UNNotificationSettings getNotificationSettings();

  // Android only
  @async
  bool areNotificationsEnabled();
}

@FlutterApi()
abstract class PushFlutterApi {
  @async
  void onMessage(RemoteMessage message);

  @async
  void onBackgroundMessage(RemoteMessage message);

  /// Unfortunately, the intent provided to the app when a user taps on a
  /// notification does not include notification's title or body.
  /// In this instance, it makes more sense to remove this useful functionality from iOS too.
  /// Only the data property on the RemoteMessage is returned to the user.
  /// This is effectively the lowest common denominator API.
  ///
  /// Hint: You can still include the title, body or other metadata in your
  /// data payload to identify what notification the user tapped on.
  void onNotificationTap(Map<String?, Object?> data);

  void onNewToken(String token);

  void onOpenNotificationSettings();
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
enum UNAuthorizationStatus {
  notDetermined,
  denied,
  authorized,
  provisional,
  ephemeral
}

/// The type of notification the user will see
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unalertstyle) for more information
enum UNAlertStyle { none, banner, alert }

/// The current configuration of a notification setting
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsetting) for more information
enum UNNotificationSetting { notSupported, disabled, enabled }

/// Conditions to show/reveal notification content to the user
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unshowpreviewssetting) for more information
enum UNShowPreviewsSetting { always, whenAuthenticated, never }

/// The object for reading notification-related settings and the authorization status of your app.
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsettings) for more information
class UNNotificationSettings {
  UNAuthorizationStatus? authorizationStatus;
  UNNotificationSetting? soundSetting;
  UNNotificationSetting? badgeSetting;
  UNNotificationSetting? alertSetting;
  UNNotificationSetting? notificationCenterSetting;
  UNNotificationSetting? lockScreenSetting;
  UNNotificationSetting? carPlaySetting;
  UNAlertStyle? alertStyle;
  UNShowPreviewsSetting? showPreviewsSetting;
  UNNotificationSetting? criticalAlertSetting;
  bool? providesAppNotificationSettings;
  UNNotificationSetting? announcementSetting;
}
