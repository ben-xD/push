library push_platform;

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:push_platform_interface/src/serialization/push_api.dart';

export 'src/serialization/push_api.dart'
    show
        RemoteMessage1,
        Notification,
        UNNotificationSettings,
        UNNotificationSetting,
        UNAlertStyle,
        UNAuthorizationStatus;

typedef MessageHandler = FutureOr<void> Function(RemoteMessage1 message);

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

  final _onMessageHandlers = <MessageHandler>{};
  final _onBackgroundMessageHandlers = <MessageHandler>{};

  /// Called when notification is received when app is in the foreground.
  /// Remember to unsubscribe.
  /// Multiple listeners can be listening.
  VoidCallback addOnMessage(MessageHandler handler) {
    _sendAndroidReadyToProcessMessages();
    _onMessageHandlers.add(handler);
    return () {
      _onMessageHandlers.remove(handler);
    };
  }

  // Optional: to clear all handlers so you're sure there are no listeners.
  void resetHandlers() {
    _isReadyToProcessMessage = false;
    _onMessageHandlers.clear();
    _onBackgroundMessageHandlers.clear();
  }

  /// Called when notification is received when app is terminated or in the background.
  VoidCallback addOnBackgroundMessage(MessageHandler handler) {
    _sendAndroidReadyToProcessMessages();
    _onBackgroundMessageHandlers.add(handler);
    return () {
      _onBackgroundMessageHandlers.remove(handler);
    };
  }

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
    return await _pushHostApi.getNotificationTapWhichLaunchedTerminatedApp();
  }

  /// Get the token identifying the device for push notifications.
  ///
  /// On Android, this is the FCM registration token
  /// On iOS, this is the APNs device token.
  Future<String?> get token => _pushHostApi.getToken();

  VoidCallback? onOpenSettingsHandler;

  /// If the flutter application was launched manually, this method tells the
  /// platform that the application is ready process messages.
  ///
  /// This is only valid for Android.
  bool _isReadyToProcessMessage = false;
  void _sendAndroidReadyToProcessMessages() {
    if (!_isReadyToProcessMessage) {
      _isReadyToProcessMessage = true;
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
  }

  Future<UNNotificationSettings> getNotificationSettings() {
    return _pushHostApi.getNotificationSettings();
  }

  Future<bool> areNotificationsEnabled() {
    return _pushHostApi.areNotificationsEnabled();
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
    PushFlutterApi.setUp(this);
  }

  @override
  Future<void> onBackgroundMessage(RemoteMessage1 message) async {
    for (final handler in push._onBackgroundMessageHandlers) {
      await handler(message);
    }
  }

  @override
  Future<void> onMessage(RemoteMessage1 message) async {
    for (final handler in push._onMessageHandlers) {
      await handler(message);
    }
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
}
