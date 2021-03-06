// Autogenerated from Pigeon (v3.0.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PUUNAuthorizationStatus) {
  PUUNAuthorizationStatusNotDetermined = 0,
  PUUNAuthorizationStatusDenied = 1,
  PUUNAuthorizationStatusAuthorized = 2,
  PUUNAuthorizationStatusProvisional = 3,
  PUUNAuthorizationStatusEphemeral = 4,
};

typedef NS_ENUM(NSUInteger, PUUNAlertStyle) {
  PUUNAlertStyleNone = 0,
  PUUNAlertStyleBanner = 1,
  PUUNAlertStyleAlert = 2,
};

typedef NS_ENUM(NSUInteger, PUUNNotificationSetting) {
  PUUNNotificationSettingNotSupported = 0,
  PUUNNotificationSettingDisabled = 1,
  PUUNNotificationSettingEnabled = 2,
};

typedef NS_ENUM(NSUInteger, PUUNShowPreviewsSetting) {
  PUUNShowPreviewsSettingAlways = 0,
  PUUNShowPreviewsSettingWhenAuthenticated = 1,
  PUUNShowPreviewsSettingNever = 2,
};

@class PURemoteMessage;
@class PUNotification;
@class PUUNNotificationSettings;

@interface PURemoteMessage : NSObject
+ (instancetype)makeWithNotification:(nullable PUNotification *)notification
    data:(nullable NSDictionary<NSString *, id> *)data;
@property(nonatomic, strong, nullable) PUNotification * notification;
@property(nonatomic, strong, nullable) NSDictionary<NSString *, id> * data;
@end

@interface PUNotification : NSObject
+ (instancetype)makeWithTitle:(nullable NSString *)title
    body:(nullable NSString *)body;
@property(nonatomic, copy, nullable) NSString * title;
@property(nonatomic, copy, nullable) NSString * body;
@end

@interface PUUNNotificationSettings : NSObject
+ (instancetype)makeWithAuthorizationStatus:(PUUNAuthorizationStatus)authorizationStatus
    soundSetting:(PUUNNotificationSetting)soundSetting
    badgeSetting:(PUUNNotificationSetting)badgeSetting
    alertSetting:(PUUNNotificationSetting)alertSetting
    notificationCenterSetting:(PUUNNotificationSetting)notificationCenterSetting
    lockScreenSetting:(PUUNNotificationSetting)lockScreenSetting
    carPlaySetting:(PUUNNotificationSetting)carPlaySetting
    alertStyle:(PUUNAlertStyle)alertStyle
    showPreviewsSetting:(PUUNShowPreviewsSetting)showPreviewsSetting
    criticalAlertSetting:(PUUNNotificationSetting)criticalAlertSetting
    providesAppNotificationSettings:(nullable NSNumber *)providesAppNotificationSettings
    announcementSetting:(PUUNNotificationSetting)announcementSetting;
@property(nonatomic, assign) PUUNAuthorizationStatus authorizationStatus;
@property(nonatomic, assign) PUUNNotificationSetting soundSetting;
@property(nonatomic, assign) PUUNNotificationSetting badgeSetting;
@property(nonatomic, assign) PUUNNotificationSetting alertSetting;
@property(nonatomic, assign) PUUNNotificationSetting notificationCenterSetting;
@property(nonatomic, assign) PUUNNotificationSetting lockScreenSetting;
@property(nonatomic, assign) PUUNNotificationSetting carPlaySetting;
@property(nonatomic, assign) PUUNAlertStyle alertStyle;
@property(nonatomic, assign) PUUNShowPreviewsSetting showPreviewsSetting;
@property(nonatomic, assign) PUUNNotificationSetting criticalAlertSetting;
@property(nonatomic, strong, nullable) NSNumber * providesAppNotificationSettings;
@property(nonatomic, assign) PUUNNotificationSetting announcementSetting;
@end

/// The codec used by PUPushHostApi.
NSObject<FlutterMessageCodec> *PUPushHostApiGetCodec(void);

@protocol PUPushHostApi
- (nullable NSDictionary<NSString *, id> *)getNotificationTapWhichLaunchedTerminatedAppWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)getTokenWithCompletion:(void(^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)backgroundFlutterApplicationReadyWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)onListenToOnNewTokenWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)onCancelToOnNewTokenWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)requestPermissionBadge:(NSNumber *)badge sound:(NSNumber *)sound alert:(NSNumber *)alert carPlay:(NSNumber *)carPlay criticalAlert:(NSNumber *)criticalAlert provisional:(NSNumber *)provisional providesAppNotificationSettings:(NSNumber *)providesAppNotificationSettings announcement:(NSNumber *)announcement completion:(void(^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)getNotificationSettingsWithCompletion:(void(^)(PUUNNotificationSettings *_Nullable, FlutterError *_Nullable))completion;
@end

extern void PUPushHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<PUPushHostApi> *_Nullable api);

/// The codec used by PUPushFlutterApi.
NSObject<FlutterMessageCodec> *PUPushFlutterApiGetCodec(void);

@interface PUPushFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)onMessageMessage:(PURemoteMessage *)message completion:(void(^)(NSError *_Nullable))completion;
- (void)onBackgroundMessageMessage:(PURemoteMessage *)message completion:(void(^)(NSError *_Nullable))completion;
- (void)onNotificationTapData:(NSDictionary<NSString *, id> *)data completion:(void(^)(NSError *_Nullable))completion;
- (void)onNewTokenToken:(NSString *)token completion:(void(^)(NSError *_Nullable))completion;
- (void)onOpenNotificationSettingsWithCompletion:(void(^)(NSError *_Nullable))completion;
@end
NS_ASSUME_NONNULL_END
