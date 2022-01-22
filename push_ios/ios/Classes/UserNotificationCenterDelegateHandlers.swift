import Foundation

class UserNotificationCenterDelegateHandlers: NSObject, UNUserNotificationCenterDelegate {
    private let originalDelegate: UNUserNotificationCenterDelegate?
    private let pushFlutterApi: PUPushFlutterApi

    init(with originalDelegate: UNUserNotificationCenterDelegate?, pushFlutterApi: PUPushFlutterApi) {
        self.originalDelegate = originalDelegate
        self.pushFlutterApi = pushFlutterApi
        super.init()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UserNotifications.UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> ()) {
        let message = PURemoteMessage.fromNotificationContent(content: notification.request.content)
        pushFlutterApi.showNotification(inForegroundMessage: message) { isShowNotificationSelected, error in
            guard error != nil else {
                print("userNotificationCenter:willPresent: received error: \(String(describing: error)), defaulting to hide notification.")
                completionHandler([])
                return
            }
            if isShowNotificationSelected as! Bool {
                if #available(iOS 14.0, *) {
                    completionHandler(.banner)
                } else {
                    completionHandler(.alert)
                }
            } else {
                completionHandler([])
            }

        }
    }

    private var userTapsOnNotificationCount = 0;
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> ()) {
        // Avoid sending the message that launched the app. We will send that one when the user requests for the "Push.instance.notificationTapWhichLaunchedAppFromTerminated" (Dart code)
        if (userTapsOnNotificationCount > 0) {
//            let message = PURemoteMessage.fromNotificationContent(content: response.notification.request.content)
            pushFlutterApi.onNotificationTapData(response.notification.request.content.userInfo as! [String: Any]) { _ in  }
        }
        callOriginalDidReceiveDelegateMethod(center: center, response: response, completionHandler: completionHandler)
        userTapsOnNotificationCount += 1
    }

    // Allow users original UNUserNotificationCenterDelegate they set to respond.
    private func callOriginalDidReceiveDelegateMethod(center: UNUserNotificationCenter, response: UNNotificationResponse, completionHandler: @escaping () -> ()) { // `as` is used because userNotificationCenter on its own is ambiguous (userNotificationCenter corresponds to 3 methods).
        // See https://stackoverflow.com/questions/35658334/how-do-i-resolve-ambiguous-use-of-compile-error-with-swift-selector-syntax
        let didReceiveDelegateMethodSelector = #selector(userNotificationCenter as (UNUserNotificationCenter, UNNotificationResponse, @escaping () -> Void) -> Void)
        if let originalDelegate = originalDelegate, originalDelegate.responds(to: didReceiveDelegateMethodSelector) {
            originalDelegate.userNotificationCenter?(center, didReceive: response, withCompletionHandler: completionHandler)
        } else {
            completionHandler()
        }
    }

    @available(iOS 12.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UserNotifications.UNNotification?) {
        pushFlutterApi.onOpenNotificationSettings { _ in
        }
        callOriginalOpenSettingsForDelegateMethod(center: center, notification: notification)
    }

    @available(iOS 12.0, *)
    private func callOriginalOpenSettingsForDelegateMethod(center: UNUserNotificationCenter, notification: UserNotifications.UNNotification?) {
        let openSettingsForDelegateMethodSelector = #selector(userNotificationCenter as (UNUserNotificationCenter, UNNotification?) -> Void)
        if let originalDelegate = originalDelegate, originalDelegate.responds(to: openSettingsForDelegateMethodSelector) {
            originalDelegate.userNotificationCenter?(center, openSettingsFor: notification)
        }
    }
}
