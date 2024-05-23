#if os(iOS)
import Flutter
import UIKit

public typealias DarwinApplication = UIApplication
#elseif os(macOS)
import FlutterMacOS
import UserNotifications

public typealias DarwinApplication = NSApplication
#endif

@available(macOS 11.0, *)
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
    /**
        Since FlutterPlugin for MacOs does not provide all NSApplicaitonDelegates and wraps them with conviences delegates
        we cannot use same way as for iOS. This means register remote notification must done here and the developer using this plugin must
        forward delegates from @NSApplicationMain to the one from this class. 
     */
    public func handleDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.registerForRemoteNotifications()
                
        if let notificationResponse = notification.userInfo?[NSApplication.launchUserNotificationUserInfoKey] as! UNNotificationResponse?  {
            PushHostHandlers.notificationTapWhichLaunchedAppUserInfo = notificationResponse.toMap()
        }
    }
        
    /**
            According to Apple docs: The delegate receives this message when the application is running and a remote notification arrives for it.
     */
    public func application(_ application: DarwinApplication, didReceiveRemoteNotification userInfo: [String : Any]) {
        pushHostHandlers.didReceiveRemoteNotification(
            application,
            didReceiveRemoteNotification: userInfo
        )
    }
#endif
}
