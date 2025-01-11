import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const debugChannel = AndroidNotificationChannel(
  'debug',
  'Debug',
  description:
      'This channel is used to demo all notifications manually for development/debug purposes.',
  importance: Importance.max,
);

const toiletPaperChannel = AndroidNotificationChannel(
  'toilet_paper',
  'Toilet Paper',
  description:
      'This channel is used to notify you when toilet paper has run out.',
  importance: Importance.max,
);

final _flutterLocalNotifications = FlutterLocalNotificationsPlugin()
    .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

void configureAndroidPushNotificationChannels() async {
  if (!Platform.isAndroid) {
    return;
  }

  await _flutterLocalNotifications!.createNotificationChannel(debugChannel);
  await _flutterLocalNotifications!
      .createNotificationChannel(toiletPaperChannel);
}
