# Push

Handles push notifications - including background notification, alert notifications and notification taps - all without installing Firebase on Flutter running on any host platform (except for Android).

- Look at the features [features](#features) if you want to see if `push` will provide it.
- Look at [comparisons](#comparisons) if you want to compare `Push` with other push notification packages for Flutter.

## Features

- Use push notification without Firebase on any platform except Android.
- Get started testing push notifications quickly with the scripts, tools and commands provided in this project.
- Consistent behaviour between iOS and Android.
- It currently only supported iOS and Android.
- Avoids using deprecated Android classes.
- Receive push notifications when the app is in the foreground, background or terminated on Android
  and iOS.
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

- You must use firebase_messaging
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

There are 2 things you need to do.
- [Install/configure your app for push notification](#installation)
- [Write code to handle push notifications](#usage)

### Installation

Warning: Setting up push notifications is more difficult than most features, because:

- we don't have control over the push notification servers (when the message is pushed to your app)
- after the device receives the push notification from the server, we don't have control over when
  the OS delivers push notifications to our app

#### Android

- Set up your firebase project, add your Android app to the project, and follow the steps in the Firebase web console. For example,
    - download the `google-services.json` into the `android/app/` folder.
    - Modify your Android project to include the following 2 lines - you can check exactly where this needs to go by looking at the example app:
        - Add `apply plugin: 'com.google.gms.google-services'` to your app's `android/app/build.gradle`.
        - Add `classpath 'com.google.gms:google-services:4.3.10'` to your app's `android/build.gradle`.
    - See [example app files](example/android/app/build.gradle) for an example.
- Add `push` to your `pubspec.yaml`
- Download/update dependencies by running `flutter pub get`

#### iOS

- Warning: you need an [Apple Developer Program](https://developer.apple.com/programs/) membership -
  $99 a year.
- Create a push notifications key on your apple developer
  account's [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/authkeys/list)
  page.

### Usage

Warning: In the specific case where your Android app is in the terminated state and a push
notification is received, any side effects caused by your handlers must complete before the
completing the handler. This is because the Flutter application may be terminated as soon as the
Future of the handler completes.

## Manual testing and debugging

### iOS

- Manual testing:
    - Set up your developer account
    - Copy `test_manual/ios/send_ios_example.sh` into a new file which won't be committed to git (
      in `.gitignore`) by
      running: `cp test_manual/ios/send_ios_example.sh test_manual.ios/send_ios.sh`
    - Make the file executable: `chmod +x test_manual/ios/send_ios.sh`
    - Run the script to send the push notification: `./test_manual/ios/send_ios.sh`
- Debugging: Take a look at my
  guide, [Debugging Push Notifications on iOS](https://orth.uk/ios-push-notifications-debugging).

### Android

- Set up the FCM push notification project in `test_manual/android`

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

## Credits

The architecture of this package was originally designed by me as part
of [`ably_flutter`](https://pub.dev/packages/ably_flutter). `ably_flutter` is a Flutter plugin for
Ably, a realtime messaging service that powers synchronized digital experiences in realtime.
However, this package is simpler and written in Swift, Kotlin and Pigeon (Dart codegenerator)
instead of Objective-C, Java and manual serialization code.

## Contributing

To provide feedback, contribute features, bug fixes, documentation, or anything else to this
project, read [CONTRIBUTING.md](CONTRIBUTING.md).