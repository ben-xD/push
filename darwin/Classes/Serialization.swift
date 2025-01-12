import Foundation
#if os(macOS)
    // Needed on macOS, otherwise build won't find e.g. UNUserNotificationCenterDelegate. Optional on iOS.
    import UserNotifications
#endif

extension PURemoteMessage {
    static func from(userInfo: [AnyHashable: Any]) -> PURemoteMessage {
        let message = PURemoteMessage()
        message.data = userInfo as? [String: Any]
        message.notification = PUNotification.from(userInfo: userInfo)
        return message
    }

    static func fromNotificationContent(content: UNNotificationContent) -> PURemoteMessage {
        let message = PURemoteMessage()
        message.data = content.userInfo as? [String: Any]

        let notification = PUNotification()
        notification.title = content.title
        notification.body = content.body
        message.notification = notification

        return message
    }
}

extension PUNotification {
    static func from(userInfo: [AnyHashable: Any]) -> PUNotification? {
        let notification = PUNotification()

        guard let aps = userInfo["aps"] as? [AnyHashable: Any] else {
            return nil
        }

        if let alert = aps["alert"] as? [AnyHashable: Any] {
            notification.title = alert["title"] as? String
            notification.body = alert["body"] as? String
            return notification
        } else if let title = aps["alert"] as? String {
            notification.title = title
            return notification
        } else {
            return nil
        }
    }
}

extension PUUNNotificationSettings {
    static func from(unSettings: UNNotificationSettings) -> PUUNNotificationSettings {
        let settings = PUUNNotificationSettings()
        settings.soundSetting = PUUNNotificationSettingBox(value: unSettings.soundSetting.toSerializable())
        settings.badgeSetting = PUUNNotificationSettingBox(value: unSettings.badgeSetting.toSerializable())
        settings.alertSetting = PUUNNotificationSettingBox(value: unSettings.alertSetting.toSerializable())
        settings.notificationCenterSetting = PUUNNotificationSettingBox(value: unSettings.notificationCenterSetting.toSerializable())
        settings.lockScreenSetting = PUUNNotificationSettingBox(value: unSettings.lockScreenSetting.toSerializable())
        settings.authorizationStatus = PUUNAuthorizationStatusBox(value: unSettings.authorizationStatus.toSerializable())
        settings.alertStyle = PUUNAlertStyleBox(value: unSettings.alertStyle.toSerializable())
        if #available(iOS 11.0, *) {
            settings.showPreviewsSetting = PUUNShowPreviewsSettingBox(value: unSettings.showPreviewsSetting.toSerializable())
        } else {
            // Fallback on earlier versions
            settings.showPreviewsSetting = PUUNShowPreviewsSettingBox(value: .always)
        }

        if #available(iOS 12.0, *) {
            settings.providesAppNotificationSettings = NSNumber(booleanLiteral: unSettings.providesAppNotificationSettings)
            settings.criticalAlertSetting = PUUNNotificationSettingBox(value: unSettings.criticalAlertSetting.toSerializable())

        } else {
            settings.providesAppNotificationSettings = false
            settings.criticalAlertSetting = PUUNNotificationSettingBox(value: .notSupported)
        }

        #if os(iOS)
            // Not available on macOS as per https://developer.apple.com/documentation/usernotifications/unnotificationsettings/carplaysetting
            settings.carPlaySetting = PUUNNotificationSettingBox(value: unSettings.carPlaySetting.toSerializable())

            // Not available on macOS as per https://developer.apple.com/documentation/usernotifications/unnotificationsettings/announcementsetting
            if #available(iOS 13.0, *) {
                settings.announcementSetting = PUUNNotificationSettingBox(value: unSettings.announcementSetting.toSerializable())
            } else {
                settings.announcementSetting = PUUNNotificationSettingBox(value: .notSupported)
            }
        #endif

        return settings
    }
}

extension UNNotificationSetting {
    func toSerializable() -> PUUNNotificationSetting {
        switch self {
        case .notSupported: return .notSupported
        case .disabled: return .disabled
        case .enabled: return .enabled
        @unknown default:
            print("Received unknown notificationSetting: \(self), defaulting to .notSupported")
            return .notSupported
        }
    }
}

extension UNAuthorizationStatus {
    func toSerializable() -> PUUNAuthorizationStatus {
        switch self {
        case .notDetermined: return .notDetermined
        case .denied: return .denied
        case .authorized: return .authorized
        case .provisional: return .provisional
        case .ephemeral: return .ephemeral
        @unknown default:
            print("Received unknown UNAuthorizationStatus: \(self), defaulting to .notDetermined")
            return .notDetermined
        }
    }
}

extension UNAlertStyle {
    func toSerializable() -> PUUNAlertStyle {
        switch self {
        case .none: return .none
        case .banner: return .banner
        case .alert: return .alert
        @unknown default:
            print("Received unknown UNAlertStyle: \(self), defaulting to .alert")
            return .alert
        }
    }
}

@available(iOS 11.0, *)
extension UNShowPreviewsSetting {
    func toSerializable() -> PUUNShowPreviewsSetting {
        switch self {
        case .always: return .always
        case .whenAuthenticated: return .whenAuthenticated
        case .never: return .never
        @unknown default:
            print("Received unknown UNShowPreviewsSetting: \(self), defaulting to .whenAuthenticated")
            return .whenAuthenticated
        }
    }
}

#if os(macOS)
    extension UNNotificationResponse {
        func toMap() -> [AnyHashable: Any] {
            // We can get a lot more information from a UNNotificationResponse, but to be consistent with iOS, we return the userInfo only (e.g. {aps: {alert: {title, body}, extraData: "some more data", content-available: 1}}).
            return notification.request.content.userInfo
        }
    }
#endif
