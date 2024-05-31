# [`Push`](/push), a Flutter package for push notifications

This is a repository following the [federated plugin](https://docs.flutter.dev/packages-and-plugins/developing-packages#federated-plugins) structure.

## Documentation

Take a look at the [documentation](push/README.md) in the "app facing package" (`push`).

## Contributing

Take a look at the [contributing](CONTRIBUTING.md) guide.

# Fork Changes for iOS Only (when using Firebase for Android)
These are the changes made for iOS Only

## Adding forked package to your <project>
Added to a project's `packages/` folder as a submodule with these standard git commands:
```
# assuming packages/ folder
cd <project>/packages;

# clone it as a submodule
git submodule add git@github.com:sonjz/push;

# NOTE: if you ever do a fresh clone you need to initialize submodule
git submodule update --init;

```

## Disabling non-iOS platforms and enabling Local Packages
In `push/pubspec.yaml` I've removed `push_android` and `push_macos` as they are no longer required libraries.  But since this is a fork we are using locally, we need to reference the local package vs ones that would be fetched from pub.dev.

@ben-xD also mentioned this comment that changing defaults for plugins (like removing Android) is in the works by flutter.
https://github.com/ben-xD/push/issues/61#issuecomment-2141618459

```
# push/pubspec.yaml
...

# had to add this as it was complaining
publish_to: none

...

dependencies:
  flutter:
    sdk: flutter

  # Federated package dependencies
  #push_platform_interface: ^0.6.0
  #push_android: ^0.6.0
  #push_ios: ^0.5.1
  #push_macos: ^0.0.1
  # End of federated package dependencies

  # When developing push locally, make sure
  # For example, I often make the mistake where I update the local cache
  # of published push_ios, then try and run the app using the local push_ios.
  # My changes don't get to run.
  # A huge pain of federated packages.

  # Local development dependencies -
  # uncomment this and comment out the federated package dependencies
  push_platform_interface:
    path: "../push_platform_interface"
  # push_android:
  #   path: "../push_android"
  push_ios:
    path: "../push_ios"
  # push_macos:
  #   path: "../push_macos"
# End of local development dependencies

...

flutter:
  uses-material-design: false
  plugin:
    platforms:
      #android:
      #  default_package: push_android
      ios:
        default_package: push_ios

...
```

Additionally in `push_ios` we had to reference locally as well.
```
# push_ios/pubspec.yaml
...

# had to add this as it was complaining
publish_to: none

...

dependencies:
  flutter:
    sdk: flutter

  # Federated package dependencies
  # push_platform_interface: ^0.6.0

  # Local development dependencies
  push_platform_interface:
    path: "../push_platform_interface"
  # End of local dependencies

...
```

