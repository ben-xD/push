# Contributing guide

In this guide, I try to help you contribute feature requests, bug reports, bug fixes and features to this project. Take a look at useful tips to help you investigate or learn the package a bit better.

## Types of contributions

I may create templates for these in the future.

### Feature requests

Please create an issue describing what features you want. If you have any idea on the implementation, that would be helpful.

### Bug report

Please provide as much information as possible. For example, the state of the application when the push notification is received.

### Bug fixes

You can also contribute bug fixes yourself, by forking this repo on GitHub, and opening a pull request. I will try to take a look, and keep an eye on GitHub notifications.

### Features

You can give also contribute feature implementations to the project. If the feature is relatively large or complex, discussing it in a GitHub issue can help you think through the feature and contribute higher quality code.

## Concepts

### Data types

iOS and Android have different structures for push notifications.
Android's [RemoteMessage](https://firebase.google.com/docs/reference/android/com/google/firebase/messaging/RemoteMessage)
has a lot more metadata than iOS's [userInfo dictionary](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623013-application).

To add more types this package's RemoteMessage type, you need to do 2 things:
- Add more fields to the data type in `pigeons/push_api.dart`
- Fill this field on the platform side:
  - On Android, in `Serialization.kt`, extract more of `RemoteMessage` into the `Map`. Make sure that the keys you use for the map correspond to the fields in RemoteMessage.

### Pigeon

Pigeon is used to generate code which serializes and deserializes data, including method calls and types between Flutter and the Host.
- Implementation of methods called from the other side are called `PushXHandlers`, for example `PushHostHandlers` and `PushFlutterHandlers`.
- Instances used to call methods on the other side of the serialization barrier have been called: `PushXApi`, for example `PushHostApi` and `PushFlutterApi`.

To (re)generate pigeon files:
- Run `cd push_platform_interface`
- Run `dart run pigeon --input pigeons/push_api.dart`

#### Manual adjustments
- When re-generating Pigeon code, it might break. I made 1 small adjustment to the generated code to fix the issue reported in https://github.com/flutter/flutter/issues/101515

## Useful commands

### Android

- Nice logs in command line: `pidcat com.example.app`
- Check if app process is runnning `watch -n 1 'adb -s emulator-5554 shell ps -A | grep push'`
  - Even pressing down on app icon (launching popup menu) launches the app
- Kill an application process: put the app in the background, then run `adb shell am kill uk.orth.push.example`
- Take screenshot with scrcpy: `adb exec-out screencap -p > "screenshot_$(date +%s).png"`
- Reboot emulator :`adb -e reboot`


### iOS
- Install [SwiftFormat](https://github.com/nicklockwood/SwiftFormat): `brew install swiftformat`
- Format files: run `make format` or `swiftformat .`
