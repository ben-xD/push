import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:push/push.dart';
import 'package:push_example/metadata_sliver.dart';
import 'package:push_example/platform_specific/android.dart';
import 'package:push_example/remote_messages_widget.dart';
import 'package:push_example/text_row.dart';

import 'notification_permission_sliver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationWhichLaunchedApp = useState<Map<String?, Object?>?>(null);
    final messagesReceived = useState<List<RemoteMessage>>([]);
    final backgroundMessagesReceived = useState<List<RemoteMessage>>([]);
    final tappedNotificationPayloads =
    useState<List<Map<String?, Object?>>>([]);

    useEffect(() {
      configureAndroidPushNotificationChannels();

      // To be informed that the device's token has been updated by the operating system
      // You should update your servers with this token
      Push.instance.onNewToken.listen((token) {
        print("Just got a new token: $token");
      });

      // Handle notification launching app from terminated state
      Push.instance.notificationTapWhichLaunchedAppFromTerminated.then((data) {
        if (data == null) {
          print("App was not launched by tapping a notification");
        } else {
          print('Notification tap launched app from terminated state:\n'
              'Data: ${data} \n');
        }
        notificationWhichLaunchedApp.value = data;
      });

      // Handle notification taps
      Push.instance.onNotificationTap.listen((data) {
        print('Notification was tapped:\n'
            'Data: ${data} \n');
        tappedNotificationPayloads.value += [data];
      });

      // Handle push notifications
      Push.instance.onMessage.listen((message) {
        print('RemoteMessage received while app is in foreground:\n'
            'RemoteMessage.Notification: ${message.notification} \n'
            ' title: ${message.notification?.title.toString()}\n'
            ' body: ${message.notification?.body.toString()}\n'
            'RemoteMessage.Data: ${message.data}');
        messagesReceived.value += [message];
      });

      // Handle push notifications
      Push.instance.onBackgroundMessage.listen((message) {
        print('RemoteMessage received while app is in background:\n'
            'RemoteMessage.Notification: ${message.notification} \n'
            ' title: ${message.notification?.title.toString()}\n'
            ' body: ${message.notification?.body.toString()}\n'
            'RemoteMessage.Data: ${message.data}');
        backgroundMessagesReceived.value += [message];
      });
    }, []);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Push Example App'),
        ),
        body: Center(
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Instructions',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4),
                  Text(
                      "Use the push token below to send messages using the tools provided in the folder called `test_manual/`. You should see these messages arrive to the device, and show up on this screen, based on your actions.")
                ],
              ),
              const NotificationPermissionSliver(),
              const MetadataSliver(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Messages',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4),
                    Text('Recent foreground notification',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5),
                    RemoteMessagesWidget(messagesReceived.value),
                    Text('Recent background notification',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5),
                    RemoteMessagesWidget(backgroundMessagesReceived.value),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Notification Taps',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4),
                    Text("Notifications are only shown when the app is "
                        "terminated or in the background. If you want to "
                        "show a notification when the app is running, you "
                        "have to manually create the notification."),
                    Text("Only the data property (payloads) is shown when a "
                        "notification is tapped. This is done to make "
                        "behaviour consistent between  iOS and Android. "
                        "To know which notification the user saw/tapped, "
                        "you can duplicate the title/body in the data "
                        "payload - redundant I know."),
                    Text('Notification which launched app',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5),
                    const Text(
                        "There can only be 1 notification which launched your app."),
                    Text((notificationWhichLaunchedApp.value != null)
                        ? notificationWhichLaunchedApp.value.toString()
                        : "The app was not launched by an app pressing the notification."),
                    Text('All notifications tapped since app launch',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5),
                    buildTappedNotificationsSliver(
                        context, tappedNotificationPayloads.value),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTappedNotificationsSliver(BuildContext context,
      List<Map<String?, Object?>> tappedNotificationPayloads) {
    if (tappedNotificationPayloads.isEmpty) {
      return const Text("No payloads");
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              ...tappedNotificationPayloads
                  .map((data) => TextRow("Data", data.toString()))
                  .toList()
            ],
          ),
        ],
      );
    }
  }
}
