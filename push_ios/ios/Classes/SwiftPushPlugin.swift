import Flutter
import UIKit

public class SwiftPushPlugin: NSObject, FlutterPlugin {
    private let flutterPluginRegistrar: FlutterPluginRegistrar
    private var pushHostHandlers: PushHostHandlers
    public static var instance: SwiftPushPlugin? = nil

    public static func register(with registrar: FlutterPluginRegistrar) {
        instance = SwiftPushPlugin(with: registrar)
    }

    init(with registrar: FlutterPluginRegistrar) {
        flutterPluginRegistrar = registrar
        pushHostHandlers = PushHostHandlers(binaryMessenger: flutterPluginRegistrar.messenger(),
                                            originalDelegate: UNUserNotificationCenter.current().delegate)
        super.init()
        registrar.addApplicationDelegate(self)
    }

    public func application(_: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any]) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()

        let notification = launchOptions[UIApplication.LaunchOptionsKey.remoteNotification] as! [AnyHashable: Any]?
        if notification != nil {
            PushHostHandlers.notificationTapWhichLaunchedAppUserInfo = notification
        }

        return true
    }

    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushHostHandlers.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        pushHostHandlers.didReceiveRemoteNotification(
            application,
            didReceiveRemoteNotification: userInfo,
            fetchCompletionHandler: completionHandler
        )
    }

    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        pushHostHandlers.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
}
