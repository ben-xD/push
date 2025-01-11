// Autogenerated from Pigeon (v22.7.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

List<Object?> wrapResponse(
    {Object? result, PlatformException? error, bool empty = false}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
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
  ephemeral,
}

/// The type of notification the user will see
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unalertstyle) for more information
enum UNAlertStyle {
  none,
  banner,
  alert,
}

/// The current configuration of a notification setting
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsetting) for more information
enum UNNotificationSetting {
  notSupported,
  disabled,
  enabled,
}

/// Conditions to show/reveal notification content to the user
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unshowpreviewssetting) for more information
enum UNShowPreviewsSetting {
  always,
  whenAuthenticated,
  never,
}

class RemoteMessage {
  RemoteMessage({
    this.notification,
    this.data,
  });

  Notification? notification;

  Map<String?, Object?>? data;

  Object encode() {
    return <Object?>[
      notification,
      data,
    ];
  }

  static RemoteMessage decode(Object result) {
    result as List<Object?>;
    return RemoteMessage(
      notification: result[0] as Notification?,
      data: (result[1] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
    );
  }
}

class Notification {
  Notification({
    this.title,
    this.body,
  });

  String? title;

  String? body;

  Object encode() {
    return <Object?>[
      title,
      body,
    ];
  }

  static Notification decode(Object result) {
    result as List<Object?>;
    return Notification(
      title: result[0] as String?,
      body: result[1] as String?,
    );
  }
}

/// The object for reading notification-related settings and the authorization status of your app.
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsettings) for more information
class UNNotificationSettings {
  UNNotificationSettings({
    this.authorizationStatus,
    this.soundSetting,
    this.badgeSetting,
    this.alertSetting,
    this.notificationCenterSetting,
    this.lockScreenSetting,
    this.carPlaySetting,
    this.alertStyle,
    this.showPreviewsSetting,
    this.criticalAlertSetting,
    this.providesAppNotificationSettings,
    this.announcementSetting,
  });

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

  Object encode() {
    return <Object?>[
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
    ];
  }

  static UNNotificationSettings decode(Object result) {
    result as List<Object?>;
    return UNNotificationSettings(
      authorizationStatus: result[0] as UNAuthorizationStatus?,
      soundSetting: result[1] as UNNotificationSetting?,
      badgeSetting: result[2] as UNNotificationSetting?,
      alertSetting: result[3] as UNNotificationSetting?,
      notificationCenterSetting: result[4] as UNNotificationSetting?,
      lockScreenSetting: result[5] as UNNotificationSetting?,
      carPlaySetting: result[6] as UNNotificationSetting?,
      alertStyle: result[7] as UNAlertStyle?,
      showPreviewsSetting: result[8] as UNShowPreviewsSetting?,
      criticalAlertSetting: result[9] as UNNotificationSetting?,
      providesAppNotificationSettings: result[10] as bool?,
      announcementSetting: result[11] as UNNotificationSetting?,
    );
  }
}

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is UNAuthorizationStatus) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is UNAlertStyle) {
      buffer.putUint8(130);
      writeValue(buffer, value.index);
    } else if (value is UNNotificationSetting) {
      buffer.putUint8(131);
      writeValue(buffer, value.index);
    } else if (value is UNShowPreviewsSetting) {
      buffer.putUint8(132);
      writeValue(buffer, value.index);
    } else if (value is RemoteMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is Notification) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is UNNotificationSettings) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : UNAuthorizationStatus.values[value];
      case 130:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : UNAlertStyle.values[value];
      case 131:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : UNNotificationSetting.values[value];
      case 132:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : UNShowPreviewsSetting.values[value];
      case 133:
        return RemoteMessage.decode(readValue(buffer)!);
      case 134:
        return Notification.decode(readValue(buffer)!);
      case 135:
        return UNNotificationSettings.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class PushHostApi {
  /// Constructor for [PushHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  PushHostApi(
      {BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix =
            messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  /// Returns null if it doesn't exist.
  /// See [PushFlutterApi.onNotificationTap] to understand why a RemoteMessage is not provided here.
  Future<Map<String?, Object?>?>
      getNotificationTapWhichLaunchedTerminatedApp() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.getNotificationTapWhichLaunchedTerminatedApp$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return (pigeonVar_replyList[0] as Map<Object?, Object?>?)
          ?.cast<String?, Object?>();
    }
  }

  Future<String> getToken() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.getToken$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as String?)!;
    }
  }

  /// Android only
  /// Delete the token. You'll get a new one immediately on [PushFlutterApi.onNewToken].
  ///
  /// The old token would be invalid, and trying to send a FCM message to it
  ///  will get an error: `Requested entity was not found.`
  Future<void> deleteToken() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.deleteToken$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// iOS only
  /// Temporary disable receiving push notifications until next app restart. You can re-enable immediately with [PushHostApi.registerForRemoteNotifications].
  /// This might be useful if you're logging someone out or you want to completely disable all notifications.
  /// Trying to send an APNs message to the token will fail, until `registerForRemoteNotifications` is called.
  /// For iOS details, see https://developer.apple.com/documentation/uikit/uiapplication/1623093-unregisterforremotenotifications
  /// Warning: on IOS simulators, no notifications will be delivered when calling unregisterForRemoteNotifications and then `registerForRemoteNotifications`
  Future<void> unregisterForRemoteNotifications() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.unregisterForRemoteNotifications$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// iOS only
  /// Registration is done automatically when the application starts.
  /// This is only useful if you previously called [PushHostApi.unregisterForRemoteNotifications].
  /// You'll get the next token from [PushFlutterApi.onNewToken]. Unfortunately, this would most likely be
  /// the same token as before you called [PushHostApi.unregisterForRemoteNotifications].
  Future<void> registerForRemoteNotifications() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.registerForRemoteNotifications$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> backgroundFlutterApplicationReady() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.backgroundFlutterApplicationReady$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  /// Pass true for the option you want permission to use
  /// Returns true if permission was granted.
  Future<bool> requestPermission(
      bool badge,
      bool sound,
      bool alert,
      bool carPlay,
      bool criticalAlert,
      bool provisional,
      bool providesAppNotificationSettings,
      bool announcement) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.requestPermission$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[
      badge,
      sound,
      alert,
      carPlay,
      criticalAlert,
      provisional,
      providesAppNotificationSettings,
      announcement
    ]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<UNNotificationSettings> getNotificationSettings() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.getNotificationSettings$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as UNNotificationSettings?)!;
    }
  }

  Future<bool> areNotificationsEnabled() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.push_platform_interface.PushHostApi.areNotificationsEnabled$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }
}

abstract class PushFlutterApi {
  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  Future<void> onMessage(RemoteMessage message);

  Future<void> onBackgroundMessage(RemoteMessage message);

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

  static void setUp(
    PushFlutterApi? api, {
    BinaryMessenger? binaryMessenger,
    String messageChannelSuffix = '',
  }) {
    messageChannelSuffix =
        messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onMessage$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onMessage was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final RemoteMessage? arg_message = (args[0] as RemoteMessage?);
          assert(arg_message != null,
              'Argument for dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onMessage was null, expected non-null RemoteMessage.');
          try {
            await api.onMessage(arg_message!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onBackgroundMessage$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onBackgroundMessage was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final RemoteMessage? arg_message = (args[0] as RemoteMessage?);
          assert(arg_message != null,
              'Argument for dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onBackgroundMessage was null, expected non-null RemoteMessage.');
          try {
            await api.onBackgroundMessage(arg_message!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onNotificationTap$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onNotificationTap was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final Map<String?, Object?>? arg_data =
              (args[0] as Map<Object?, Object?>?)?.cast<String?, Object?>();
          assert(arg_data != null,
              'Argument for dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onNotificationTap was null, expected non-null Map<String?, Object?>.');
          try {
            api.onNotificationTap(arg_data!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onNewToken$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onNewToken was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_token = (args[0] as String?);
          assert(arg_token != null,
              'Argument for dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onNewToken was null, expected non-null String.');
          try {
            api.onNewToken(arg_token!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.push_platform_interface.PushFlutterApi.onOpenNotificationSettings$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          try {
            api.onOpenNotificationSettings();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
