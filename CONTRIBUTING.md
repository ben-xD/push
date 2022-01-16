# Contributing

## Introduction

If you find a bug, want a feature or anything else, create a GitHub issue or contribute the work yourself.

## Concepts

### Data types

iOS and Android have different representations of push notifications. 
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

The command used is to (re)generate pigeon files is: `cd push && flutter pub run pigeon --input pigeons/push_api.dart` 