# Tools for push notifications

## Setup

- Install Node
- Install pnpm: `npm install --global pnpm`
- Install dependencies: `pnpm install`
- Create config.yaml and update it: `cp example.config.yaml config.yaml`

## Usage

Run your app. Get the device token and update `config.yaml`

Run `pnpm start`, e.g. `pnpm start --android` or `pnpm start --ios`

For more information, run `pnpm start --help`

## Known issues

- iOS Simulators don't seem to support background message on simulators (when app is in foreground or background). A real device will be more realistic/helpful (less confusing).
- We can't use bun or node's built-in fetch for connecting to APNs, because they don't support HTTP/2. See https://github.com/oven-sh/bun/issues/7194. We use fetch-h2 to support HTTP/2

## Resources

- You can also use Apple's [Push Notification Console](https://developer.apple.com/documentation/usernotifications/testing-notifications-using-the-push-notification-console) to test push notifications. There is a quick shortcut button to open the page in Xcode > Targets > Target name > Signing & Capabilities > Push Notifications, but this is buggy and may open the wrong app on developer.apple.com.
- For more help with debugging on iOS, take a look at my
guide, [Debugging Push Notifications on iOS](https://orth.uk/ios-push-notifications-debugging).
- To debug Android push notifications whilst the app is in the terminated state, take a look at [How to debug Android apps (including Flutter) without launching from the debugger?](https://orth.uk/debug-android-and-flutter-from-launch).
