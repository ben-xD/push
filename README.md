# `Push`, for Flutter

Handles push notifications - including background notification, alert notifications and notification taps - all without installing Firebase on Flutter running on any host platform (except for Android).

- For information about `Push`, take a look at the [push "app-facing" package](push/README.md).

# Why federated?

You can provide a custom implementation for a specific platform by releasing your own package which implements the interface provided by [push_platform_interface](https://pub.dev/packages/push_platform_interface). Even if your package is not endorsed in `push`, other users of this package can use your implementation by modifying their `pubspec.yaml`.

# Contributing

Take a look at the [contributing](CONTRIBUTING.md) guide.
