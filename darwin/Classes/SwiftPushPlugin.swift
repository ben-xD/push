#if os(iOS)
    import Flutter
    import UIKit

    public typealias DarwinApplication = UIApplication
#elseif os(macOS)
    import FlutterMacOS
    import UserNotifications

    public typealias DarwinApplication = NSApplication
#endif

public class SwiftPushPlugin: NSObject, FlutterPlugin {
    private let flutterPluginRegistrar: FlutterPluginRegistrar
    private var pushHostHandlers: PushHostHandlers
    public static var instance: SwiftPushPlugin? = nil

    public static func register(with registrar: FlutterPluginRegistrar) {
        instance = SwiftPushPlugin(with: registrar)
    }

    init(with registrar: FlutterPluginRegistrar) {
        flutterPluginRegistrar = registrar
        #if os(iOS)
            pushHostHandlers = PushHostHandlers(binaryMessenger: flutterPluginRegistrar.messenger(),
                                                originalDelegate: UNUserNotificationCenter.current().delegate)
        #elseif os(macOS)
            pushHostHandlers = PushHostHandlers(binaryMessenger: flutterPluginRegistrar.messenger,
                                                originalDelegate: UNUserNotificationCenter.current().delegate)
        #endif
        super.init()
        registrar.addApplicationDelegate(self)
    }

    public func application(_ application: DarwinApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushHostHandlers.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    public func application(_ application: DarwinApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        pushHostHandlers.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }

    #if os(iOS)
        public func application(_: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any]) -> Bool {
            UIApplication.shared.registerForRemoteNotifications()

            let notification = launchOptions[UIApplication.LaunchOptionsKey.remoteNotification] as! [AnyHashable: Any]?
            if notification != nil {
                PushHostHandlers.notificationTapWhichLaunchedAppUserInfo = notification
            }

            return true
        }

        public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
            pushHostHandlers.didReceiveRemoteNotification(
                application,
                didReceiveRemoteNotification: userInfo,
                fetchCompletionHandler: completionHandler
            )
        }

    #elseif os(macOS)
        // Notification forwarded from NSApplicationDelegate. See  https://developer.apple.com/documentation/appkit/nsapplicationdelegate/applicationdidfinishlaunching(_:)
        public func handleDidFinishLaunching(_ notification: Notification) {
            NSApplication.shared.registerForRemoteNotifications()

            // launchUserNotificationUserInfoKey is: "A key that indicates your app was launched because a user activated a notification in the Notification Center."
            // See https://developer.apple.com/documentation/usernotifications/unnotificationresponse and  https://developer.apple.com/documentation/appkit/nsapplication/launchusernotificationuserinfokey
            if let notificationResponse = notification.userInfo?[NSApplication.launchUserNotificationUserInfoKey] as! UNNotificationResponse? {
                PushHostHandlers.notificationTapWhichLaunchedAppUserInfo = notificationResponse.toMap()
            }
        }

        public func application(_ application: NSApplication, didReceiveRemoteNotification userInfo: [String: Any]) {
            pushHostHandlers.didReceiveRemoteNotification(
                application,
                didReceiveRemoteNotification: userInfo
            )
        }
    #endif
}
