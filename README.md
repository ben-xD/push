# Push

This is a federated package. 

- For usage, take a look at the push "app-facing" package, [Push](push).
- For installation, see the platform specific package.

# Why federated?

You can provide a custom implementation for a specific platform by releasing your own package which implements the interface provided by [push_platform_interface](https://pub.dev/packages/push_platform_interface). Even if your package is not endorsed in `push`, other users of this package can use your implementation by modifying their `pubspec.yaml`.

# Contributing

Take a look at the [contributing](CONTRIBUTING.md) guide.