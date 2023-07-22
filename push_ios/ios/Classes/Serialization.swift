import Foundation

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
        settings.soundSetting = unSettings.soundSetting.toSerializable()
        settings.badgeSetting = unSettings.badgeSetting.toSerializable()
        settings.alertSetting = unSettings.alertSetting.toSerializable()
        settings.notificationCenterSetting = unSettings.notificationCenterSetting.toSerializable()
        settings.lockScreenSetting = unSettings.lockScreenSetting.toSerializable()
        settings.carPlaySetting = unSettings.carPlaySetting.toSerializable()
        settings.authorizationStatus = unSettings.authorizationStatus.toSerializable()
        settings.alertStyle = unSettings.alertStyle.toSerializable()

        if #available(iOS 11.0, *) {
            settings.showPreviewsSetting = unSettings.showPreviewsSetting.toSerializable()
        } else {
            // Fallback on earlier versions
            settings.showPreviewsSetting = .always
        }

        if #available(iOS 12.0, *) {
            settings.providesAppNotificationSettings = NSNumber(booleanLiteral: unSettings.providesAppNotificationSettings)
            settings.criticalAlertSetting = unSettings.criticalAlertSetting.toSerializable()

        } else {
            settings.providesAppNotificationSettings = false
            settings.criticalAlertSetting = .notSupported
        }

        if #available(iOS 13.0, *) {
            settings.announcementSetting = unSettings.announcementSetting.toSerializable()
        } else {
            settings.announcementSetting = .notSupported
        }

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
