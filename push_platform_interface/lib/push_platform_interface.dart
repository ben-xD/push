library push_platform;

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:push_platform_interface/src/serialization/push_api.dart';

export 'src/serialization/push_api.dart'
    show
    RemoteMessage,
    Notification,
    UNNotificationSettings,
    UNNotificationSetting,
    UNAlertStyle,
    UNAuthorizationStatus;

/// The interface that implementations of [`push`](https://pub.dev/packages/push) must implement.
///
/// Platform implementations must **extend** this class rather than implement it
/// as `push` does not consider newly added methods to be breaking changes.
///
/// This is because of the differences between:
/// - Extending this class (using `extends`): implementation gets default
/// implementation, so no work is needed except updating the dependency version.
/// - Implementing this class (using `implements`): interface will be broken
/// by newly added methods, meaning more code to be added (more work),
/// but custom implementation (more control).
class Push extends PlatformInterface {
  Push() : super(token: _token) {
    _onBackgroundMessageStreamController.onListen = _readyToProcessMessages;
    _onNewTokenStreamController.onListen =
        () => _pushHostApi.onListenToOnNewToken();
    _onNewTokenStreamController.onCancel =
        () => _pushHostApi.onCancelToOnNewToken();
    PushFlutterHandlers(this);
  }

  static final Object _token = Object();
  static Push _instance = Push();

  /// The default instance of [Push] to use.
  ///
  /// Defaults to [Push] implemented in `push_platform_interface`.
  static Push get instance => _instance;
  final PushHostApi _pushHostApi = PushHostApi();

  final StreamController<RemoteMessage> _onMessageStreamController =
      StreamController();
  final StreamController<RemoteMessage> _onBackgroundMessageStreamController =
      StreamController();
  final StreamController<Map<String?, Object?>>
      _onNotificationTapStreamController = StreamController();
  final StreamController<String> _onNewTokenStreamController =
      StreamController();

  /// Platform-specific plugins should override this with their own
  /// platform-specific class that extends [VideoPlayerPlatform] when they
  /// register themselves.
  static set instance(Push instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Notification received when app is in the foreground.
  Stream<RemoteMessage> get onMessage => _onMessageStreamController.stream;

  /// Notification received when app is terminated or in the background.
  Stream<RemoteMessage> get onBackgroundMessage =>
      _onBackgroundMessageStreamController.stream;

  /// Notification that was tapped whilst the app is already running in the foreground or background.
  /// This requires the notification to contain `data`. The actual notification is not available.
  /// This is an intermittently working feature. Sometimes, Android delivers an intent with no extras,
  /// meaning we can't provide the notification from ther user.
  Stream<Map<String?, Object?>> get onNotificationTap =>
      _onNotificationTapStreamController.stream;

  /// A new FCM registration token update. (Passing the result of FirebaseMessagingService#onNewToken to Flutter app)
  Stream<String> get onNewToken => _onNewTokenStreamController.stream;

  /// Get the notification tapped by the user when the app was in the
  /// terminated state. This does not include the case where a push
  /// notification is received when the app is in  the background but
  ///  still running.
  ///
  /// The future completes with [null] if the app was not launched by a user
  /// tapping a notification.
  Future<Map<String?, Object?>?>
      get notificationTapWhichLaunchedAppFromTerminated async {
    if (await _pushHostApi.notificationTapLaunchedTerminatedApp()) {
      return await _pushHostApi.getNotificationTapWhichLaunchedTerminatedApp();
    } else {
      return null;
    }
  }

  /// Get the token identifying the device for push notifications.
  ///
  /// On Android, this is the FCM registration token
  /// On iOS, this is the APNs device token.
  Future<String?> get token => _pushHostApi.getToken();

  Future<bool> Function(RemoteMessage message)?
      onShowNotificationInForegroundHandler;

  VoidCallback? onOpenSettingsHandler;

  /// If the flutter application was launched manually, this method tells the
  /// platform that the application is ready process messages.
  ///
  /// This is only valid for Android.
  void _readyToProcessMessages() {
    if (Platform.isAndroid) {
      try {
        _pushHostApi.backgroundFlutterApplicationReady();
      } catch (e) {
        print("Ignoring this exception because the application is already "
            "running. This method is useful when the application"
            " is not yet launched (Terminated state). Error: $e");
      }
    }
  }

  Future<UNNotificationSettings> getNotificationSettings() {
    return _pushHostApi.getNotificationSettings();
  }

  /// For more information, see the underlying [Apple documentation](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649527-requestauthorization).
  Future<bool> requestPermission({
    bool badge = true,
    bool sound = true,
    bool alert = true,
    bool carPlay = true,
    bool criticalAlert = false,
    bool provisional = false,
    bool providesAppNotificationSettings = false,
    bool announcement = true,
  }) {
    return _pushHostApi.requestPermission(
      badge,
      sound,
      alert,
      carPlay,
      criticalAlert,
      provisional,
      providesAppNotificationSettings,
      announcement,
    );
  }
}

class PushFlutterHandlers extends PushFlutterApi {
  Push push;

  PushFlutterHandlers(this.push) {
    PushFlutterApi.setup(this);
  }

  @override
  void onBackgroundMessage(RemoteMessage message) {
    push._onBackgroundMessageStreamController.add(message);
  }

  @override
  void onMessage(RemoteMessage message) {
    push._onMessageStreamController.add(message);
  }

  @override
  void onNewToken(String token) {
    push._onNewTokenStreamController.add(token);
  }

  @override
  void onNotificationTap(Map<String?, Object?> message) {
    push._onNotificationTapStreamController.add(message);
  }

  @override
  void onOpenNotificationSettings() {
    final handler = push.onOpenSettingsHandler;
    if (handler != null) handler();
  }

  @override
  Future<bool> showNotificationInForeground(RemoteMessage message) async {
    final handler = push.onShowNotificationInForegroundHandler;
    if (handler != null) return handler(message);
    return false;
  }
}
