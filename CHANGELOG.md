## 3.3.3

- fix(android): lower java version back to 1.8

## 3.3.2

- fix(ios): fix(ios): fix swift call after renaming argument in pigeon dart file

## 3.3.1

- Update description and issue tracker link

## 3.3.0

- feat: upgrade to kotlin 2.1.0, android build tools 8.7.3

## 3.2.0

- Add support for macOS
- [iOS, macOS]: add manual `Push.instance.registerForRemoteNotifications()` and `Push.instance.unregisterForRemoteNotifications()`

## 3.1.1

- docs: remove references to federation

## 3.1.0

- replace federated package with simpler design

## 3.0.0

- feat: replace all stream APIs with callback APIs
- Update pigeon to 22.7.2

## 2.3.0

- Update pigeon to 18.0.0

## 2.2.0

- support Android 14 and AGP 8

## 2.1.0

- Replace generated Java with generated Kotlin (pigeon)

## 2.0.1

- Update pigeon to 16.0.0

## 2.0.0

- Replace streams API with callbacks

## 2.0.0-dev.1

- Replace streams API with callbacks

## 1.1.0

- Update pigeon to 15.0.2

## 1.0.5

- [feature(ios): Added logic to parse and use presentation parameters](https://github.com/ben-xD/push/pull/33)

## 1.0.4

- [fix(ios): don't show duplicate first tapped notification #25](https://github.com/ben-xD/push/pull/25). First one didn't fix it.

## 1.0.3

- [fix(ios): don't show duplicate first tapped notification #25](https://github.com/ben-xD/push/pull/25)

## 1.0.2

- [fix(android): fix PushApi.RemoteMessage notification attribute serialization](https://github.com/ben-xD/push/pull/21)

## 1.0.1

- fix(ios): fix first notification tap

## 1.0.0

- feat: support requesting permissions to show notification to users on Android (required on Android 13 and newer).
- feat: upgrade kotlin, gradle and flutter versions

## 0.1.3

- fix: allow APNs messages to be handled in onMessage (when app is in foreground) even when `content-available` is not `1`.

## 0.1.2

- fix: android local notifications. They weren't showing because `flutter_local_notifications` needed more configuration.

## 0.1.1

- update to Pigeon 3.0.3
- fix: allow users to use other packages for local notifications (e.g. `flutter_local_notifications`)
- feat: add checkbox to example app to allow users to configure foreground notifications to be shown.

## 0.1.0

- update to Pigeon 2.0.3
- fix: Use latest `push_ios` and `push_android` package

## 0.0.5

- Use latest `push_ios` package

## 0.0.4

- docs: fix broken links in documentation

## 0.0.3

- fix: Use latest release of platform implementations

## 0.0.2

- feat: handle push notifications whilst app is terminated, in the background or in the foreground.
- feat: handle notification taps whilst app is terminated, in the background or in the foreground.

## 0.0.1

- Reserve pub.dev package name