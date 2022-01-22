# push_platform_interface

Platform interface implemented by federated packages for [`push`](https://pub.dev/packages/push).

## Usage

To implement a new platform-specific implementation of `push`, 
- extend `PushPlatform` with an implementation that performs platform-specific behaviour. For example, on windows you would define a `WindowsPushPlatform`.
- During plugin registration, set the default `PushPlatform` on `PushPlatform.instance`. For example, on windows you would define a `PushPlatform.instance = WindowsPushPlatform;`.

## Contributing

The contents of this file was inspired from another plugin, [video_player](https://github.com/flutter/plugins/tree/master/packages/video_player/video_player_platform_interface)

Strongly prefer non-breaking changes (such as adding a method to the interface) over breaking changes for this package.

The [federated plugin implementations](https://flutter.dev/go/platform-interface-breaking-changes) explains why. My understanding is that it introduces 2 issues:

- Gives developers more work: This interface is used by a multiple platform implementations (and their developers) so any breaking change will give additional work to these implementations and implementers.
- Introduces unnecessary restriction: If one specific platform (e.g. Windows) introduces a breaking change which also gives the platform interface a breaking change - a major release is required for both packages. This means all other platform implementations need to update to use this latest interface. More importantly, **app developers won't be able to use this latest release of the new feature in the specific platform (e.g. Windows) until all platform implementations implement this interface. They are locked (pinned down) to the older version of all packages.