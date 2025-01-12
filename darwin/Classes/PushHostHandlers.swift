import Foundation
#if os(macOS)
    // Needed on macOS, otherwise build won't find e.g. UNUserNotificationCenterDelegate. Optional on iOS.
    import UserNotifications
#endif

class PushHostHandlers: NSObject, PUPushHostApi {
    private var deviceTokenReadyDispatchGroupEnters: Int = 0

    func requestPermissionBadge(
        _ badge: Bool,
        sound: Bool,
        alert: Bool,
        carPlay: Bool,
        criticalAlert: Bool,
        provisional: Bool,
        providesAppNotificationSettings: Bool,
        announcement: Bool,
        completion: @escaping (NSNumber?, FlutterError?) -> Void
    ) {
        var options: UNAuthorizationOptions = []

        if badge {
            options.insert(.badge)
        }
        if sound {
            options.insert(.sound)
        }
        if alert {
            options.insert(.alert)
        }
        if carPlay {
            options.insert(.carPlay)
        }
        if #available(iOS 12.0, *) {
            if criticalAlert {
                options.insert(.criticalAlert)
            }
            if provisional {
                options.insert(.provisional)
            }
            if providesAppNotificationSettings {
                options.insert(.providesAppNotificationSettings)
            }
        }
        #if os(iOS)
            if #available(iOS 13.0, *) {
                if announcement {
                    options.insert(.announcement)
                }
            }
        #endif

        UNUserNotificationCenter.current().requestAuthorization(options: options) {
            granted, error in
            guard error == nil else {
                completion(
                    nil,
                    FlutterError(
                        code: "requestPermission", message: error.debugDescription, details: error
                    )
                )
                return
            }
            completion(granted as NSNumber, nil)
        }
    }

    func getNotificationSettings(
        completion: @escaping (PUUNNotificationSettings?, FlutterError?) -> Void
    ) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            completion(PUUNNotificationSettings.from(unSettings: settings), nil)
        }
    }

    private let delegate: UNUserNotificationCenterDelegate
    private let pushFlutterApi: PUPushFlutterApi
    public static var notificationTapWhichLaunchedAppUserInfo: [AnyHashable: Any]? = nil

    let deviceTokenReadyDispatchGroup = DispatchGroup()

    // TODO: double check that the delegate is still the same later, in case the user had set it? and log error.
    init(
        binaryMessenger: FlutterBinaryMessenger, originalDelegate: UNUserNotificationCenterDelegate?
    ) {
        pushFlutterApi = PUPushFlutterApi(binaryMessenger: binaryMessenger)
        delegate = UserNotificationCenterDelegateHandlers(
            with: originalDelegate, pushFlutterApi: pushFlutterApi
        )
        UNUserNotificationCenter.current().delegate = delegate
        super.init()
        enterDeviceTokenReadyDispatchGroup() // DeviceToken is not yet ready
        SetUpPUPushHostApi(binaryMessenger, self)
    }

    func notificationTapLaunchedTerminatedAppWithError(
        _: AutoreleasingUnsafeMutablePointer<FlutterError?>
    ) -> NSNumber? {
        if PushHostHandlers.notificationTapWhichLaunchedAppUserInfo != nil {
            return true
        } else {
            return false
        }
    }

    func getNotificationTapWhichLaunchedTerminatedAppWithError(
        _: AutoreleasingUnsafeMutablePointer<FlutterError?>
    ) -> [String: Any]? {
        let userInfo = PushHostHandlers.notificationTapWhichLaunchedAppUserInfo
        return userInfo as? [String: Any]
    }

    func application(
        _: DarwinApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        onNewToken(deviceToken)
        leaveDeviceTokenReadyDispatchGroup()
    }

    func getTokenWithCompletion(_ completion: @escaping (String?, FlutterError?) -> Void) {
        if let deviceToken = deviceToken {
            completion(convertTokenToString(deviceToken: deviceToken), nil)
        } else {
            print(
                "DeviceToken is not available (it is \(String(describing: deviceToken))). "
                    + "Your application might not be configured for push notifications, or there is a "
                    + "delay in getting the device token because of network issues. "
                    + "Background thread is now waiting for it to be set.")
            DispatchQueue.global(qos: .userInitiated).async { [self] in
                deviceTokenReadyDispatchGroup.notify(queue: DispatchQueue.global(qos: .background)) { [self] in
                    DispatchQueue.main.async {
                        completion(self.convertTokenToString(deviceToken: self.deviceToken!), nil)
                    }
                }
                self.deviceTokenReadyDispatchGroup.wait()
            }
            return
        }
    }

    func deleteToken(completion: @escaping (FlutterError?) -> Void) {
        completion(nil)
    }

    func registerForRemoteNotificationsWithError(
        _: AutoreleasingUnsafeMutablePointer<FlutterError?>
    ) {
        DarwinApplication.shared.registerForRemoteNotifications()
    }

    func unregisterForRemoteNotificationsWithError(
        _: AutoreleasingUnsafeMutablePointer<FlutterError?>
    ) {
        DarwinApplication.shared.unregisterForRemoteNotifications()
    }

    // Ignored on iOS, since the Flutter application doesn't need to be manually launched.
    func backgroundFlutterApplicationReadyWithError(
        _: AutoreleasingUnsafeMutablePointer<FlutterError?>
    ) {}

    func areNotificationsEnabled(completion: @escaping (NSNumber?, FlutterError?) -> Void) {
        completion(
            nil,
            FlutterError(
                code: "areNotificationsEnabled",
                message: "Android only API. Do not call this on iOS.", details: nil
            )
        )
    }

    #if os(iOS)
        func didReceiveRemoteNotification(
            _ application: UIApplication,
            didReceiveRemoteNotification userInfo: [AnyHashable: Any],
            fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
        ) -> Bool {
            let message = PURemoteMessage.from(userInfo: userInfo)
            if application.applicationState == .background || application.applicationState == .inactive { // App in background or terminated
                pushFlutterApi.onBackgroundMessageMessage(message) { _ in
                    completionHandler(.newData)
                }
            } else { // App in foreground
                let aps = userInfo["aps"] as? [String: Any]
                let isAlertMessage = aps?["alert"] != nil
                // if "alert" APNs message, it is already sent in UserNotificationCenterDelegateHandlers userNotificationCenter_willPresent
                if !isAlertMessage {
                    // If "background" APNs message (it doesn't contain alert), we need to send it to onMessage.
                    pushFlutterApi.onMessageMessage(message) { _ in
                        completionHandler(.newData)
                    }
                } else {
                    completionHandler(.newData)
                }
            }
            return true
        }

    #elseif(os(macOS))
        // https://developer.apple.com/documentation/appkit/nsapplicationdelegate/application(_:didreceiveremotenotification:)
        func didReceiveRemoteNotification(
            _ application: NSApplication,
            didReceiveRemoteNotification userInfo: [AnyHashable: Any]
        ) {
            // No push notification delivered when app is terminated.

            let message = PURemoteMessage.from(userInfo: userInfo)
            if application.isActive == false { // App in background
                pushFlutterApi.onBackgroundMessageMessage(message) { _ in }
            } else { // App in foreground
                // Might need to check "alert" key and skip sending if message is only send if not alert (alert already sent)

                let aps = userInfo["aps"] as? [String: Any]
                let isAlertMessage = aps?["alert"] != nil
                // if "alert" APNs message, it is already sent in UserNotificationCenterDelegateHandlers userNotificationCenter_willPresent
                if !isAlertMessage {
                    // If "background" APNs message (it doesn't contain alert), we need to send it to onMessage.
                    pushFlutterApi.onMessageMessage(message) { _ in }
                }
            }
        }
    #endif

    private var deviceToken: Data? = nil

    private func convertTokenToString(deviceToken: Data) -> String {
        let token = deviceToken.map {
            String(format: "%02.2hhx", $0)
        }.joined()
        return token
    }

    // TODO: handle the case where deviceToken is nil (not yet created)
    // TODO: what about other cases, e.g. error (onError?)

    func onNewToken(_ deviceToken: Data) {
        self.deviceToken = deviceToken
        let deviceTokenString = convertTokenToString(deviceToken: deviceToken)
        // TODO: replace this with log levels, verbose logging:
        print("APNs Device Token: \(deviceTokenString)")
        pushFlutterApi.onNewTokenToken(deviceTokenString) { _ in
        }
    }

    public func application(
        _: DarwinApplication, didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        // Log an error.
        print("Failed to register device for remote notifications. Error: \(error)")
    }

    private func enterDeviceTokenReadyDispatchGroup() {
        if deviceTokenReadyDispatchGroupEnters < 0 {
            deviceTokenReadyDispatchGroupEnters = 0
        }
        deviceTokenReadyDispatchGroupEnters += 1
        deviceTokenReadyDispatchGroup.enter()
    }

    private func leaveDeviceTokenReadyDispatchGroup() {
        deviceTokenReadyDispatchGroupEnters -= 1
        if deviceTokenReadyDispatchGroupEnters >= 0 {
            deviceTokenReadyDispatchGroup.leave()
        }
    }
}
