import Cocoa
import FlutterMacOS
import push

@main
class AppDelegate: FlutterAppDelegate {
    override func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        return true
    }

    override func applicationSupportsSecureRestorableState(_: NSApplication) -> Bool {
        return true
    }

    // on macOS, we need to listen to events from the system and forward it to the push package plugin.
    // This is because the Flutter engine doesn't do this for plugins on macOS.
    override func application(_ application: NSApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        SwiftPushPlugin.instance?.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    override func application(_ application: NSApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        SwiftPushPlugin.instance?.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }

    override func application(_ application: NSApplication, didReceiveRemoteNotification userInfo: [String: Any]) {
        SwiftPushPlugin.instance?.application(application, didReceiveRemoteNotification: userInfo)
    }
}
