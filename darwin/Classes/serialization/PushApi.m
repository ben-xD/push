// Autogenerated from Pigeon (v22.7.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "PushApi.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray<id> *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}

static FlutterError *createConnectionError(NSString *channelName) {
  return [FlutterError errorWithCode:@"channel-error" message:[NSString stringWithFormat:@"%@/%@/%@", @"Unable to establish connection on channel: '", channelName, @"'."] details:@""];
}

static id GetNullableObjectAtIndex(NSArray<id> *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
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
@implementation PUUNAuthorizationStatusBox
- (instancetype)initWithValue:(PUUNAuthorizationStatus)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

/// The type of notification the user will see
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unalertstyle) for more information
@implementation PUUNAlertStyleBox
- (instancetype)initWithValue:(PUUNAlertStyle)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

/// The current configuration of a notification setting
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unnotificationsetting) for more information
@implementation PUUNNotificationSettingBox
- (instancetype)initWithValue:(PUUNNotificationSetting)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

/// Conditions to show/reveal notification content to the user
///
/// See the [Apple documentation](https://developer.apple.com/documentation/usernotifications/unshowpreviewssetting) for more information
@implementation PUUNShowPreviewsSettingBox
- (instancetype)initWithValue:(PUUNShowPreviewsSetting)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

@interface PURemoteMessage ()
+ (PURemoteMessage *)fromList:(NSArray<id> *)list;
+ (nullable PURemoteMessage *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@interface PUNotification ()
+ (PUNotification *)fromList:(NSArray<id> *)list;
+ (nullable PUNotification *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@interface PUUNNotificationSettings ()
+ (PUUNNotificationSettings *)fromList:(NSArray<id> *)list;
+ (nullable PUUNNotificationSettings *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@implementation PURemoteMessage
+ (instancetype)makeWithNotification:(nullable PUNotification *)notification
    data:(nullable NSDictionary<NSString *, id> *)data {
  PURemoteMessage* pigeonResult = [[PURemoteMessage alloc] init];
  pigeonResult.notification = notification;
  pigeonResult.data = data;
  return pigeonResult;
}
+ (PURemoteMessage *)fromList:(NSArray<id> *)list {
  PURemoteMessage *pigeonResult = [[PURemoteMessage alloc] init];
  pigeonResult.notification = GetNullableObjectAtIndex(list, 0);
  pigeonResult.data = GetNullableObjectAtIndex(list, 1);
  return pigeonResult;
}
+ (nullable PURemoteMessage *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [PURemoteMessage fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    self.notification ?: [NSNull null],
    self.data ?: [NSNull null],
  ];
}
@end

@implementation PUNotification
+ (instancetype)makeWithTitle:(nullable NSString *)title
    body:(nullable NSString *)body {
  PUNotification* pigeonResult = [[PUNotification alloc] init];
  pigeonResult.title = title;
  pigeonResult.body = body;
  return pigeonResult;
}
+ (PUNotification *)fromList:(NSArray<id> *)list {
  PUNotification *pigeonResult = [[PUNotification alloc] init];
  pigeonResult.title = GetNullableObjectAtIndex(list, 0);
  pigeonResult.body = GetNullableObjectAtIndex(list, 1);
  return pigeonResult;
}
+ (nullable PUNotification *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [PUNotification fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    self.title ?: [NSNull null],
    self.body ?: [NSNull null],
  ];
}
@end

@implementation PUUNNotificationSettings
+ (instancetype)makeWithAuthorizationStatus:(nullable PUUNAuthorizationStatusBox *)authorizationStatus
    soundSetting:(nullable PUUNNotificationSettingBox *)soundSetting
    badgeSetting:(nullable PUUNNotificationSettingBox *)badgeSetting
    alertSetting:(nullable PUUNNotificationSettingBox *)alertSetting
    notificationCenterSetting:(nullable PUUNNotificationSettingBox *)notificationCenterSetting
    lockScreenSetting:(nullable PUUNNotificationSettingBox *)lockScreenSetting
    carPlaySetting:(nullable PUUNNotificationSettingBox *)carPlaySetting
    alertStyle:(nullable PUUNAlertStyleBox *)alertStyle
    showPreviewsSetting:(nullable PUUNShowPreviewsSettingBox *)showPreviewsSetting
    criticalAlertSetting:(nullable PUUNNotificationSettingBox *)criticalAlertSetting
    providesAppNotificationSettings:(nullable NSNumber *)providesAppNotificationSettings
    announcementSetting:(nullable PUUNNotificationSettingBox *)announcementSetting {
  PUUNNotificationSettings* pigeonResult = [[PUUNNotificationSettings alloc] init];
  pigeonResult.authorizationStatus = authorizationStatus;
  pigeonResult.soundSetting = soundSetting;
  pigeonResult.badgeSetting = badgeSetting;
  pigeonResult.alertSetting = alertSetting;
  pigeonResult.notificationCenterSetting = notificationCenterSetting;
  pigeonResult.lockScreenSetting = lockScreenSetting;
  pigeonResult.carPlaySetting = carPlaySetting;
  pigeonResult.alertStyle = alertStyle;
  pigeonResult.showPreviewsSetting = showPreviewsSetting;
  pigeonResult.criticalAlertSetting = criticalAlertSetting;
  pigeonResult.providesAppNotificationSettings = providesAppNotificationSettings;
  pigeonResult.announcementSetting = announcementSetting;
  return pigeonResult;
}
+ (PUUNNotificationSettings *)fromList:(NSArray<id> *)list {
  PUUNNotificationSettings *pigeonResult = [[PUUNNotificationSettings alloc] init];
  pigeonResult.authorizationStatus = GetNullableObjectAtIndex(list, 0);
  pigeonResult.soundSetting = GetNullableObjectAtIndex(list, 1);
  pigeonResult.badgeSetting = GetNullableObjectAtIndex(list, 2);
  pigeonResult.alertSetting = GetNullableObjectAtIndex(list, 3);
  pigeonResult.notificationCenterSetting = GetNullableObjectAtIndex(list, 4);
  pigeonResult.lockScreenSetting = GetNullableObjectAtIndex(list, 5);
  pigeonResult.carPlaySetting = GetNullableObjectAtIndex(list, 6);
  pigeonResult.alertStyle = GetNullableObjectAtIndex(list, 7);
  pigeonResult.showPreviewsSetting = GetNullableObjectAtIndex(list, 8);
  pigeonResult.criticalAlertSetting = GetNullableObjectAtIndex(list, 9);
  pigeonResult.providesAppNotificationSettings = GetNullableObjectAtIndex(list, 10);
  pigeonResult.announcementSetting = GetNullableObjectAtIndex(list, 11);
  return pigeonResult;
}
+ (nullable PUUNNotificationSettings *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [PUUNNotificationSettings fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    self.authorizationStatus ?: [NSNull null],
    self.soundSetting ?: [NSNull null],
    self.badgeSetting ?: [NSNull null],
    self.alertSetting ?: [NSNull null],
    self.notificationCenterSetting ?: [NSNull null],
    self.lockScreenSetting ?: [NSNull null],
    self.carPlaySetting ?: [NSNull null],
    self.alertStyle ?: [NSNull null],
    self.showPreviewsSetting ?: [NSNull null],
    self.criticalAlertSetting ?: [NSNull null],
    self.providesAppNotificationSettings ?: [NSNull null],
    self.announcementSetting ?: [NSNull null],
  ];
}
@end

@interface PUPushApiPigeonCodecReader : FlutterStandardReader
@end
@implementation PUPushApiPigeonCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 129: {
      NSNumber *enumAsNumber = [self readValue];
      return enumAsNumber == nil ? nil : [[PUUNAuthorizationStatusBox alloc] initWithValue:[enumAsNumber integerValue]];
    }
    case 130: {
      NSNumber *enumAsNumber = [self readValue];
      return enumAsNumber == nil ? nil : [[PUUNAlertStyleBox alloc] initWithValue:[enumAsNumber integerValue]];
    }
    case 131: {
      NSNumber *enumAsNumber = [self readValue];
      return enumAsNumber == nil ? nil : [[PUUNNotificationSettingBox alloc] initWithValue:[enumAsNumber integerValue]];
    }
    case 132: {
      NSNumber *enumAsNumber = [self readValue];
      return enumAsNumber == nil ? nil : [[PUUNShowPreviewsSettingBox alloc] initWithValue:[enumAsNumber integerValue]];
    }
    case 133: 
      return [PURemoteMessage fromList:[self readValue]];
    case 134: 
      return [PUNotification fromList:[self readValue]];
    case 135: 
      return [PUUNNotificationSettings fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface PUPushApiPigeonCodecWriter : FlutterStandardWriter
@end
@implementation PUPushApiPigeonCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[PUUNAuthorizationStatusBox class]]) {
    PUUNAuthorizationStatusBox *box = (PUUNAuthorizationStatusBox *)value;
    [self writeByte:129];
    [self writeValue:(value == nil ? [NSNull null] : [NSNumber numberWithInteger:box.value])];
  } else if ([value isKindOfClass:[PUUNAlertStyleBox class]]) {
    PUUNAlertStyleBox *box = (PUUNAlertStyleBox *)value;
    [self writeByte:130];
    [self writeValue:(value == nil ? [NSNull null] : [NSNumber numberWithInteger:box.value])];
  } else if ([value isKindOfClass:[PUUNNotificationSettingBox class]]) {
    PUUNNotificationSettingBox *box = (PUUNNotificationSettingBox *)value;
    [self writeByte:131];
    [self writeValue:(value == nil ? [NSNull null] : [NSNumber numberWithInteger:box.value])];
  } else if ([value isKindOfClass:[PUUNShowPreviewsSettingBox class]]) {
    PUUNShowPreviewsSettingBox *box = (PUUNShowPreviewsSettingBox *)value;
    [self writeByte:132];
    [self writeValue:(value == nil ? [NSNull null] : [NSNumber numberWithInteger:box.value])];
  } else if ([value isKindOfClass:[PURemoteMessage class]]) {
    [self writeByte:133];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[PUNotification class]]) {
    [self writeByte:134];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[PUUNNotificationSettings class]]) {
    [self writeByte:135];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface PUPushApiPigeonCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation PUPushApiPigeonCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[PUPushApiPigeonCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[PUPushApiPigeonCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *PUGetPushApiCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    PUPushApiPigeonCodecReaderWriter *readerWriter = [[PUPushApiPigeonCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}
void SetUpPUPushHostApi(id<FlutterBinaryMessenger> binaryMessenger, NSObject<PUPushHostApi> *api) {
  SetUpPUPushHostApiWithSuffix(binaryMessenger, api, @"");
}

void SetUpPUPushHostApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger, NSObject<PUPushHostApi> *api, NSString *messageChannelSuffix) {
  messageChannelSuffix = messageChannelSuffix.length > 0 ? [NSString stringWithFormat: @".%@", messageChannelSuffix] : @"";
  /// Returns null if it doesn't exist.
  /// See [PushFlutterApi.onNotificationTap] to understand why a RemoteMessage is not provided here.
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.getNotificationTapWhichLaunchedTerminatedApp", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getNotificationTapWhichLaunchedTerminatedAppWithError:)], @"PUPushHostApi api (%@) doesn't respond to @selector(getNotificationTapWhichLaunchedTerminatedAppWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSDictionary<NSString *, id> *output = [api getNotificationTapWhichLaunchedTerminatedAppWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.getToken", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getTokenWithCompletion:)], @"PUPushHostApi api (%@) doesn't respond to @selector(getTokenWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getTokenWithCompletion:^(NSString *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// Android only
  /// Delete the token. You'll get a new one immediately on [PushFlutterApi.onNewToken].
  ///
  /// The old token would be invalid, and trying to send a FCM message to it
  ///  will get an error: `Requested entity was not found.`
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.deleteToken", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(deleteTokenWithCompletion:)], @"PUPushHostApi api (%@) doesn't respond to @selector(deleteTokenWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api deleteTokenWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// iOS only
  /// Registration is done automatically when the application starts.
  /// This is only useful if you previously called [PushHostApi.unregisterForRemoteNotifications].
  /// You'll get the next token from [PushFlutterApi.onNewToken]. Unfortunately, this would most likely be
  /// the same token as before you called [PushHostApi.unregisterForRemoteNotifications].
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.registerForRemoteNotifications", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(registerForRemoteNotificationsWithError:)], @"PUPushHostApi api (%@) doesn't respond to @selector(registerForRemoteNotificationsWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api registerForRemoteNotificationsWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// iOS only
  /// Temporary disable receiving push notifications until next app restart. You can re-enable immediately with [PushHostApi.registerForRemoteNotifications].
  /// This might be useful if you're logging someone out or you want to completely disable all notifications.
  /// Trying to send an APNs message to the token will fail, until `registerForRemoteNotifications` is called.
  /// For iOS details, see https://developer.apple.com/documentation/uikit/uiapplication/1623093-unregisterforremotenotifications
  /// Warning: on IOS simulators, no notifications will be delivered when calling unregisterForRemoteNotifications and then `registerForRemoteNotifications`
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.unregisterForRemoteNotifications", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(unregisterForRemoteNotificationsWithError:)], @"PUPushHostApi api (%@) doesn't respond to @selector(unregisterForRemoteNotificationsWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api unregisterForRemoteNotificationsWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.backgroundFlutterApplicationReady", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(backgroundFlutterApplicationReadyWithError:)], @"PUPushHostApi api (%@) doesn't respond to @selector(backgroundFlutterApplicationReadyWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api backgroundFlutterApplicationReadyWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// Pass true for the option you want permission to use
  /// Returns true if permission was granted.
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.requestPermission", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(requestPermissionBadge:sound:alert:carPlay:criticalAlert:provisional:providesAppNotificationSettings:announcement:completion:)], @"PUPushHostApi api (%@) doesn't respond to @selector(requestPermissionBadge:sound:alert:carPlay:criticalAlert:provisional:providesAppNotificationSettings:announcement:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        BOOL arg_badge = [GetNullableObjectAtIndex(args, 0) boolValue];
        BOOL arg_sound = [GetNullableObjectAtIndex(args, 1) boolValue];
        BOOL arg_alert = [GetNullableObjectAtIndex(args, 2) boolValue];
        BOOL arg_carPlay = [GetNullableObjectAtIndex(args, 3) boolValue];
        BOOL arg_criticalAlert = [GetNullableObjectAtIndex(args, 4) boolValue];
        BOOL arg_provisional = [GetNullableObjectAtIndex(args, 5) boolValue];
        BOOL arg_providesAppNotificationSettings = [GetNullableObjectAtIndex(args, 6) boolValue];
        BOOL arg_announcement = [GetNullableObjectAtIndex(args, 7) boolValue];
        [api requestPermissionBadge:arg_badge sound:arg_sound alert:arg_alert carPlay:arg_carPlay criticalAlert:arg_criticalAlert provisional:arg_provisional providesAppNotificationSettings:arg_providesAppNotificationSettings announcement:arg_announcement completion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.getNotificationSettings", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getNotificationSettingsWithCompletion:)], @"PUPushHostApi api (%@) doesn't respond to @selector(getNotificationSettingsWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getNotificationSettingsWithCompletion:^(PUUNNotificationSettings *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushHostApi.areNotificationsEnabled", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:PUGetPushApiCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(areNotificationsEnabledWithCompletion:)], @"PUPushHostApi api (%@) doesn't respond to @selector(areNotificationsEnabledWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api areNotificationsEnabledWithCompletion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface PUPushFlutterApi ()
@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@property(nonatomic, strong) NSString *messageChannelSuffix;
@end

@implementation PUPushFlutterApi

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  return [self initWithBinaryMessenger:binaryMessenger messageChannelSuffix:@""];
}
- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger messageChannelSuffix:(nullable NSString*)messageChannelSuffix{
  self = [self init];
  if (self) {
    _binaryMessenger = binaryMessenger;
    _messageChannelSuffix = [messageChannelSuffix length] == 0 ? @"" : [NSString stringWithFormat: @".%@", messageChannelSuffix];
  }
  return self;
}
- (void)onMessageMessage:(PURemoteMessage *)arg_message completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = [NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushFlutterApi.onMessage", _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:PUGetPushApiCodec()];
  [channel sendMessage:@[arg_message ?: [NSNull null]] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onBackgroundMessageMessage:(PURemoteMessage *)arg_message completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = [NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushFlutterApi.onBackgroundMessage", _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:PUGetPushApiCodec()];
  [channel sendMessage:@[arg_message ?: [NSNull null]] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onNotificationTapMessage:(NSDictionary<NSString *, id> *)arg_message completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = [NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushFlutterApi.onNotificationTap", _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:PUGetPushApiCodec()];
  [channel sendMessage:@[arg_message ?: [NSNull null]] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onNewTokenToken:(NSString *)arg_token completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = [NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushFlutterApi.onNewToken", _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:PUGetPushApiCodec()];
  [channel sendMessage:@[arg_token ?: [NSNull null]] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onOpenNotificationSettingsWithCompletion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = [NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.push.PushFlutterApi.onOpenNotificationSettings", _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:PUGetPushApiCodec()];
  [channel sendMessage:nil reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
@end

