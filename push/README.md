# Push

`Push` is a flutter package designed to handle push notifications - including background notification, alert notifications and notification taps. Users can avoid using Firebase on all platforms except Android - for example, on iOS, they can use APNs directly. In most cases, you should use Flutterfire's [Firebase Messaging](https://pub.dev/packages/firebase_messaging) package. The only case you should use `Push` is if you do not / cannot use FCM on iOS. For example, [Ably](https://ably.com/documentation/general/push/activate-subscribe) and [OneSignal](https://onesignal.com/blog/firebase-vs-onesignal/) do not use FCM on iOS. This package allows you to handle push notifications regardless of the platform specific services. However, this results in a "lowest common denominator" API: you can't expect to receive FCM message IDs or senders, as some platforms do not use FCM, so don't have FCM message IDs or "sender" fields. 

- Look at the [features](#features) if you want to see if `push` will provide it.
- Look at [comparisons](#comparisons) if you want to compare `Push` with other push notification packages for Flutter.

## Features

- Use push notification without Firebase on any platform except Android.
- Get started testing push notifications quickly with the scripts, tools and commands provided in this project.
- Consistent behaviour between iOS and Android.
- It currently only supported iOS and Android.
- Avoids using deprecated Android classes.
- Receive push notifications when the app is in the foreground, background or terminated on Android
  and iOS.
- Request permission to show notifications to the user, on iOS and Android (including Android 13+).
- Handle notifications being tapped by users.
- Set your message handlers anywhere you want, however you want. Unlike other packages, these
  restrictions do not apply:
    - It must not be an anonymous function
    - It must be a top-level function (e.g. not a class method which requires initialization)
    - Since the handler runs in its own isolate outside your applications context, it is **not
      possible to update application state or execute any UI impacting logic**. You can however
      perform logic such as HTTP requests, IO operations (updating local storage), communicate with
      other plugins etc.
- This project uses [semantic versioning](https://semver.org/).
- This package is federated. You (or an organisation) can implement push services for new platforms
  (Fuchsia, Linux) which may not already provide a mechanism for pushing data to devices from servers.

## Comparisons

Do you want another comparison - or just an improvement of existing explanations? Create an issue
with your request.

#### [firebase_messaging](https://pub.dev/packages/firebase_messaging)

- You must use firebase_messaging, even on iOS. 
  - There *might* be increased latency, as messages need to go from your server, to FCM, then to APNs (extra step), and finally to the user's device. 
  - If Firebase Messaging servers goes down (unlikely), your notifications will stop working on iOS too.
- It uses a deprecated Android
  component ([JobIntentService](https://developer.android.com/reference/androidx/core/app/JobIntentService))
  which is a service which runs at all times, listening for messages even when no messages are
  arriving to the device. Android is deprecating this class and pushing developers away from the
  paradigm of keeping services running constantly. Following the documentation, they should dispatch
  jobs using `JobScheduler.enqueue` instead. In this case, each job would be a new push
  notification. Therefore, their changes will result in the same performance as `push`.

#### [flutter_apns](https://pub.dev/packages/flutter_apns)

- This package may be "dead" now. See
  the [relevant issue](https://github.com/mwaylabs/flutter-apns/issues/75).
- It [doesn't support background notifications](https://github.com/mwaylabs/flutter-apns/issues/61).
- Fundamentally, it is flawed because of it's `pubspec.yaml`: it depends on `firebase_messaging`,
  which means you have to use Firebase on iOS too. This is because the firebase messaging flutter
  package depends on Firebase Messaging iOS SDK, which swizzles methods and doesn't expect work with
  other push notification SDKs.
- It is outdated: it doesn't support iOS 15 APIs, or even provisional notifications.
- Unfortunately, the latest versions of `flutter_apns` depend directly on `firebase_messaging`,
  leading to the same issues as using firebase_messaging directly.

#### [flutter_apns_only](https://pub.dev/packages/flutter_apns_only)

- You may try to use this, and it might work for iOS, but then how do you implement the Android
  side? You would have to install `firebase_messaging`, which would break this package.

#### [unifiedpush](https://pub.dev/packages/unifiedpush)

- This only works on Android, but not on iOS because it sets up it's own connection instead of using
  FCM/APNs.

## Getting started

To run the example app, you should:
- Clone the project
- Open the `push` package (`$repo_folder/push`) in Android Studio or Visual Studio Code, not the root folder.
- Download dependencies: `flutter pub get`
- Create and open a Firebase project
  - Add an Android application with the applicationId: `uk.orth.push.example`
  - Download the `google-services.json` and place it in `push/android/app`
  - Run the example app
- Get the FCM registration token from the app
  - This is the token which you can use to send messages to this device from your server
  - The FCM registration token is printed in the example app, but you can also share the token with another app (e.g. Google Keep)
- Send messages to the device by using it's FCM registration token, through [Firebase Admin SDK](https://firebase.google.com/docs/admin/setup).

To install this package into your own application, you should:
- [Install/configure your app for push notification](#installation)
- [Write code to handle push notifications](#usage)

### Installation

Warning: Setting up push notifications is more difficult than most features, because:

- we don't have control over the push notification servers (when the message is pushed to your app)
- after the device receives the push notification from the server, we don't have control over when
  the OS delivers push notifications to our app

#### Android

- Set up your firebase project, add your Android app to the Firebase project (using the `applicationId` defined in your `build.gradle`), and follow the steps in the Firebase web console. For example,
    - download the `google-services.json` into the `android/app/` folder.
    - Modify your Android project to include the following 2 lines - you can check exactly where this needs to go by looking at the example app:
        - Add `apply plugin: 'com.google.gms.google-services'` to your app's `android/app/build.gradle`.
        - Add `classpath 'com.google.gms:google-services:4.3.10'` to your app's `android/build.gradle`.
    - See [example app files](example/android/app/build.gradle) for an example.
- Add `push` to your `pubspec.yaml`
- Download/update dependencies by running `flutter pub get`
- Flutter applications with custom Android code (native code defined in `MainActivity`):
  - `Push` manually launches your Flutter application in response to a push notification being sent to your app when it is not yet running.
  - In this case, code defined in `MainActivity` won't run when your Flutter application
  - This may prevent your Flutter application from initializing successfully when push notifications are received when the app is terminated
  - You should instead move the custom code out of your `MainActivity`, into a new custom, `Application` class. For example, a `ExampleApplication.kt` would look like:
```kotlin
package com.example.push_example

import io.flutter.app.FlutterApplication

class ExampleApplication : FlutterApplication() {
    override fun onCreate() {
        // Run custom native code for your Android application
        super.onCreate()
    }
}
```
  - Passing data back to your Flutter application will need to be carefully designed. You don't want to attempt to communicate with the Flutter application when it has not been launched yet.
  - In your `AndroidManifest.xml`, [declare this class to handle your application lifecycle methods using `android:name=".ExampleApplication"`](https://stackoverflow.com/a/13949737/7365866).
  - This is not necessary on iOS, because your Flutter application is always available when a push notification is received, even when your app is in the terminated state.

#### iOS

- Pre-requisite: you need an [Apple Developer Program](https://developer.apple.com/programs/) membership -
  $99 a year.
- ~~Warning: APNs does not work on iOS simulators, so you won't be able to test if push notifications or use this package.~~ Push Notifications now work on iOS simulators.
- ~~Warning: Apps that are force quit on iOS will not handle push notifications due to iOS limitations.~~ Even apps that are force quit on iOS can receive push notifications now.
- Create a push notifications key on your apple developer
  account's [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/authkeys/list)
  page.

### Usage

Warning: In the specific case where your Android app is in the terminated state and a push
notification is received, any side effects caused by your handlers must complete before the
completing the handler. This is because the Flutter application may be terminated as soon as the
Future of the handler completes.

**4 concepts:**
- Request permission if you need to show notifications to the user (you don't need to do this on Android 12 and older - it will succeed immediately.)
- Notifications are shown to the user automatically
  - Notifications which contain a title and a body are shown to the user when the app is in the background or terminated state.
  - Notifications are not shown to the user when the app is in the foreground. If you want to show the user a notification, you should send a background notification to your app, and create a local notification.
- You can handle the notifications in your Flutter app
  - when the app is in the foreground
  - when the app is in the background
- You can handle notification taps

All of this is shown in the following 2 snippets:
```dart
      // Request permission to show notifications. Only do this in a meaningful place 
      // For example, users have subscribed to a news feed, preferably not when they first install/launch the app. 
      final isGranted = await Push.instance.requestPermission();
```
and
```dart
      // To be informed that the device's token has been updated by the operating system
      // You should update your servers with this token
      Push.instance.onNewToken.listen((token) {
        print("Just got a new FCM registration token: ${token}");
      });

      // Handle notification launching app from terminated state
      Push.instance.notificationTapWhichLaunchedAppFromTerminated.then((data) {
        if (data == null) {
          print("App was not launched by tapping a notification");
        } else {
          print('Notification tap launched app from terminated state:\n'
              'RemoteMessage: ${remoteMessage} \n');
        }
        notificationWhichLaunchedApp.value = data;
      });

      // Handle notification taps
      Push.instance.onNotificationTap.listen((data) {
        print('Notification was tapped:\n'
            'Data: ${data} \n');
        tappedNotificationPayloads.value += [data];
      });

      // Handle push notifications
      Push.instance.onMessage.listen((message) {
        print('RemoteMessage received while app is in foreground:\n'
            'RemoteMessage.Notification: ${message.notification} \n'
            ' title: ${message.notification?.title.toString()}\n'
            ' body: ${message.notification?.body.toString()}\n'
            'RemoteMessage.Data: ${message.data}');
        messagesReceived.value += [message];
      });

      // Handle push notifications
      Push.instance.onBackgroundMessage.listen((message) {
        print('RemoteMessage received while app is in background:\n'
            'RemoteMessage.Notification: ${message.notification} \n'
            ' title: ${message.notification?.title.toString()}\n'
            ' body: ${message.notification?.body.toString()}\n'
            'RemoteMessage.Data: ${message.data}');
        backgroundMessagesReceived.value += [message];
      });
```
- When using a `StatefulWidget`, you should store each stream you listen to (`listen()`) in your  state. You should listen to these streams in `initState`, and `cancel()` them in `dispose`.

## Manual testing and debugging

Take a look at the [`tools/`](https://github.com/ben-xD/push/tree/main/tools/) folder in the GitHub repository. It contains links to resources and tools to help you debug quickly.

## Architecture

`Push` allows you to set your message handlers anywhere you want, and however you want. `Push` sends
the push notification to your app, not a separate isolate with it's own context. This is more
convenient. Other packages
impose [some restrictions](https://firebase.flutter.dev/docs/messaging/usage#background-messages)
due to their architecture:

## When can you receive push notifications

### Foreground

The app is shown on the user's screen.

### Background

The app is not shown on the user's screen, but it is running in the background.

- You can check if your app process is running by running the
  command `watch -n 1 'adb shell ps -A | grep com.example.app_name'`, and ensuring a process is
  shown.

### Terminated

The app process is not running at all.

- You can check if your app process is running by running the
  command `watch -n 1 'adb shell ps -A | grep com.example.app_name'`, and ensuring nothing shows up.
- You can close the process by ensuring the app is in the foreground, and
  running `adb shell am kill com.example.app_name`. Warning: Do not
  use `adb shell am force-stop com.example.app_name` because this will prevent further push
  notifications from being delivered to the app, until the app is manually launched by the user.

These notifications are sent to the same handler as background messages. It may come in handy to
understand the difference between them though.

## Handling push notifications

## Handling notification taps

On Android, notification taps are only sent back to you when your RemoteMessage contains data.
Therefore, you cannot test this by sending a message from the Firebase notification composer. This
is because the RemoteMessage in the intent extras which is passed simply does not include the
notification .

## Checklist

To ensure your push notifications are successfully received, follow this checklist.

### Does your MainActivity implement any custom code?

If you have logic in your MainActivity, this does not run when Push launches your application. To
make sure that your native logic is executed even when your activity is not launched, consider
adding your logic to a FlutterApplication instead of FlutterActivity. Conceptually, it makes sense
that your Flutter application configuration is done whenever your application launches, not just
when a UI is shown (FlutterActivity).

### Are you implementing your own `FirebaseMessagingService`

If you are implementing your own `FirebaseMessagingService` or using another package which does (
e.g. firebase_messaging), be sure to call `PushPlugin.onNewToken(this, registrationToken)` in
your `FirebaseMessaging#onNewToken` override. For example:

```kotlin
override fun onNewToken(registrationToken: String) {
    super.onNewToken(registrationToken)
    PushPlugin.onNewToken(this, registrationToken)
}
```

## Why federated?

You can provide a custom implementation for a specific platform by releasing your own package which implements the interface provided by [push_platform_interface](https://pub.dev/packages/push_platform_interface). Even if your package is not endorsed in `push`, other users of this package can use your implementation by modifying their `pubspec.yaml`.

## Credits

The architecture of this package is inspired by the work I did in [`ably_flutter`](https://pub.dev/packages/ably_flutter) related to push notifications. However, this package is a complete rewrite, containing a simpler architecture and uses modern languages (Swift, Kotlin) and modern tools (e.g. Pigeon (Dart codegenerator).

## Contributing

To provide feedback, contribute features, bug fixes, documentation, or anything else to this
project, read [CONTRIBUTING.md](CONTRIBUTING.md).