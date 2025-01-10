# Updating push versions

This is a reference guide to updating your application through breaking changes in the push package.

## Breaking changes in v3.0

Similar to breaking changes in v2, listening to new tokens uses a callback based API. This removes the usage of streams completely from the API, opting for a simpler, callback API.

### Previously
```dart
final onNewTokenSubscription = Push.instance.onNewToken.listen((token) {
print("Just got a new token: $token");
});
final onNotificationTapSubscription =
    Push.instance.onNotificationTap.listen((data) {
print('Notification was tapped:\n'
    'Data: $data \n');
tappedNotificationPayloads.value += [data];
});
// Unsubscribe with:
onNewTokenSubscription.cancel();
onNotificationTapSubscription.cancel();
```

### Now
```dart
final unsubscribeOnNewToken = Push.instance.addOnNewToken((token) {
    print("Just got a new token: $token");
});
final onNotificationTapSubscription =
    Push.instance.addOnNotificationTap((data) {
        print('Notification was tapped:\n'
            'Data: $data \n');
        tappedNotificationPayloads.value += [data];
});
// Unsubscribe with:
unsubscribeOnNewToken();
unsubscribeOnNotificationTap();
```

## Breaking changes in v2


There were breaking changes introduced in v2. See how to migrate from v1.

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