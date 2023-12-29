# Breaking changes in v2

This is a reference guide to the breaking changes introduced in v2, and how to migrate from v1.

## Callback API

The stream API has been replaced with a Callback API.

### Previously
```dart
Push.instance.onMessage.listen((message) { /* do something with message */ });
Push.instance.onBackgroundMessage.listen((message) { /* do something with message */ });
```

### Now
```dart
final unsubscribeOnMessage = Push.instance.addOnMessage((message) { /* do something with message */ });
final unsubscribeOnBackgroundMessage = Push.instance.addOnBackgroundMessage((message) { /* do something with message */ });

// Unsubscribe when it makes sense
unsubscribeOnMessage();
unsubscribeOnBackgroundMessage();
```