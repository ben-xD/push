# Tools for push notifications

## Setup

- Install Node
- Install pnpm: `npm install --global pnpm`
- Install dependencies: `pnpm install`
- Switch to `tool` directory: `cd tool/`
- Create config.yaml and update it according to the comments in the file: `cp example.config.yaml config.yaml`

## Usage

- Set up example app
- Connect a device or launch an iOS/Android emulator/simulator: `flutter emulators` and `flutter emulators --launch $` 
  - skip this step for macOS
- get a device id from the output of `flutter devices`
  - skip this step for macOS
- Run your app: `flutter run -d $device_id`
  - on macOS, run `flutter run -d macos`
- Get the device token from the Flutter output or your app, and update `config.yaml`

Run `pnpm start`. For example, run
- `pnpm start` to send to all devices
- `pnpm start [--android] [--macos] [--ios]`, e.g. `pnpm start --ios` to send to specific platforms

For more information, run `pnpm start --help`

## Known issues

- iOS Simulators don't seem to support background message on simulators (when app is in foreground or background). A real device will be more realistic/helpful (less confusing).
- We can't use bun or node's built-in fetch for connecting to APNs, because they don't support HTTP/2. See https://github.com/oven-sh/bun/issues/7194. We use fetch-h2 to support HTTP/2

## Resources

- You can also use Apple's [Push Notification Console](https://developer.apple.com/documentation/usernotifications/testing-notifications-using-the-push-notification-console) to test push notifications. There is a quick shortcut button to open the page in Xcode > Targets > Target name > Signing & Capabilities > Push Notifications, but this is buggy and may open the wrong app on developer.apple.com.
- For more help with debugging on iOS, take a look at my
guide, [Debugging Push Notifications on iOS](https://orth.uk/ios-push-notifications-debugging).
- To debug Android push notifications whilst the app is in the terminated state, take a look at [How to debug Android apps (including Flutter) without launching from the debugger?](https://orth.uk/debug-android-and-flutter-from-launch).
