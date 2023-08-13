## 0.1.4

- [feature(ios): Added logic to parse and use presentation parameters](https://github.com/ben-xD/push/pull/33)

## 0.1.3

- [fix(ios): don't show duplicate first tapped notification #25](https://github.com/ben-xD/push/pull/25). The first one didn't work.

## 0.1.2

- [fix(ios): don't show duplicate first tapped notification #25](https://github.com/ben-xD/push/pull/25)

## 0.1.1

- fix(ios): fix first notification tap

## 0.1.0

- refactor: implement new push_platform_interface (no feature change)

## 0.0.6

- fix: allow APNs messages to be handled in onMessage (when app is in foreground) even when `content-available` is not `1`.

## 0.0.5

- fix: allow other packages to display local notifications

## 0.0.4

- feat: update Pigeon to 2.x and remove the now-unnecessary methods to check for null

## 0.0.3

- fix: `leave` token `DispatchGroup` more times than there are `enter`s

## 0.0.2

- feat: handle push notifications whilst app is terminated, in the background or in the foreground.
- feat: handle notification taps whilst app is terminated, in the background or in the foreground.

## 0.0.1

- Reserve pub.dev package name