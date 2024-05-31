import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push/push.dart';
import 'package:push_example/metadata_sliver.dart';
import 'package:push_example/platform_specific/android.dart';
import 'package:push_example/remote_messages_widget.dart';
import 'package:push_example/text_row.dart';
import 'notification_permission_sliver.dart';

void main() async {
  // Need to "ensureInitialized" before initializing `flutter_local_notifications`
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(await initializeFlutterLocalNotifications()));
}

// Only needed for foreground notifications.
Future<FlutterLocalNotificationsPlugin>
    initializeFlutterLocalNotifications() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  // 'mipmap/ic_launcher' taken from https://github.com/MaikuB/flutter_local_notifications/issues/32#issuecomment-389542800
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');
  // Prevent FLN from requesting permission from the user when the app launches.
  const DarwinInitializationSettings initializationSettingsApple =
      DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          requestBadgePermission: false);
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsApple,
      macOS: initializationSettingsApple);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  return flutterLocalNotificationsPlugin;
}

class MyApp extends HookWidget {
  const MyApp(this.flutterLocalNotificationsPlugin, {Key? key})
      : super(key: key);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    final notificationWhichLaunchedApp = useState<Map<String?, Object?>?>(null);
    final messagesReceived = useState<List<RemoteMessage1>>([]);
    final backgroundMessagesReceived = useState<List<RemoteMessage1>>([]);
    final tappedNotificationPayloads =
        useState<List<Map<String?, Object?>>>([]);
    final isForegroundNotificationsEnabled = useState(true);

    useEffect(() {
      configureAndroidPushNotificationChannels();

      // To be informed that the device's token has been updated by the operating system
      // You should update your servers with this token
      final onNewTokenSubscription = Push.instance.onNewToken.listen((token) {
        print("Just got a new token: $token");
      });

      // Handle notification launching app from terminated state
      Push.instance.notificationTapWhichLaunchedAppFromTerminated.then((data) {
        if (data == null) {
          print("App was not launched by tapping a notification");
        } else {
          print('Notification tap launched app from terminated state:\n'
              'Data: $data \n');
        }
        notificationWhichLaunchedApp.value = data;
      });

      // Handle notification taps
      final onNotificationTapSubscription =
          Push.instance.onNotificationTap.listen((data) {
        print('Notification was tapped:\n'
            'Data: $data \n');
        tappedNotificationPayloads.value += [data];
      });

      // Handle push notifications
      final unsubscribeOnMessage = Push.instance.addOnMessage((message) {
        print('RemoteMessage received while app is in foreground:\n'
            'RemoteMessage.Notification: ${message.notification} \n'
            ' title: ${message.notification?.title.toString()}\n'
            ' body: ${message.notification?.body.toString()}\n'
            'RemoteMessage.Data: ${message.data}');
        messagesReceived.value += [message];
        // Push Notifications won't be shown by default when the app is in the foreground.
        // TODO use the state to show local notification.
        if (message.notification != null &&
            isForegroundNotificationsEnabled.value) {
          displayForegroundNotification(message.notification!);
        }
      });

      // Handle push notifications
      final unsubscribeOnBackgroundMessage =
          Push.instance.addOnBackgroundMessage((message) {
        print('RemoteMessage received while app is in background:\n'
            'RemoteMessage.Notification: ${message.notification} \n'
            ' title: ${message.notification?.title.toString()}\n'
            ' body: ${message.notification?.body.toString()}\n'
            'RemoteMessage.Data: ${message.data}');
        backgroundMessagesReceived.value += [message];
      });

      return () {
        onNewTokenSubscription.cancel();
        onNotificationTapSubscription.cancel();
        unsubscribeOnMessage();
        unsubscribeOnBackgroundMessage();
      };
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
                      style: Theme.of(context).textTheme.headlineMedium),
                  const Text(
                      "Use the push token below to send messages using the tools provided in the folder called `test_manual/`. You should see these messages arrive to the device, and show up on this screen, based on your actions.")
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Options',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Row(
                    children: [
                      Checkbox(
                          value: isForegroundNotificationsEnabled.value,
                          onChanged: (bool? isEnabled) {
                            if (isEnabled != null) {
                              isForegroundNotificationsEnabled.value =
                                  isEnabled;
                            }
                          }),
                      const Text("Show foreground notifications"),
                    ],
                  )
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
                        style: Theme.of(context).textTheme.headlineMedium),
                    Row(children: [
                      Flexible(
                        child: Text('Recent foreground notification',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      IconButton(
                          onPressed: () {
                            messagesReceived.value = [];
                          },
                          icon: const Icon(Icons.delete))
                    ]),
                    RemoteMessagesWidget(messagesReceived.value),
                    Row(
                      children: [
                        Flexible(
                          child: Text('Recent background notification',
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        IconButton(
                            onPressed: () {
                              backgroundMessagesReceived.value = [];
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
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
                        style: Theme.of(context).textTheme.headlineMedium),
                    const Text("Notifications are only shown when the app is "
                        "terminated or in the background. If you want to "
                        "show a notification when the app is running, you "
                        "have to manually create the notification."),
                    const Text(
                        "Only the data property (payloads) is shown when a "
                        "notification is tapped. This is done to make "
                        "behaviour consistent between  iOS and Android. "
                        "To know which notification the user saw/tapped, "
                        "you can duplicate the title/body in the data "
                        "payload - redundant I know."),
                    Text('Notification which launched app',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const Text(
                        "There can only be 1 notification which launched your app."),
                    Text((notificationWhichLaunchedApp.value != null)
                        ? notificationWhichLaunchedApp.value.toString()
                        : "The app was not launched by an app pressing the notification."),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                              'All notifications tapped since app launch',
                              style: Theme.of(context).textTheme.headlineSmall),
                        ),
                        IconButton(
                            onPressed: () {
                              tappedNotificationPayloads.value = [];
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
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

  void displayForegroundNotification(Notification notification) async {
    final androidOptions =
        AndroidNotificationDetails(debugChannel.id, debugChannel.name,
            channelDescription: debugChannel.description,
            importance: Importance.max,
            priority: Priority.high,
            ticker: "A manually-sent push notification.",
            styleInformation: const DefaultStyleInformation(
              false,
              false,
            ));
    const iosOptions = DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    final platformChannelSpecifics =
        NotificationDetails(android: androidOptions, iOS: iosOptions);
    await flutterLocalNotificationsPlugin.show(
        0, notification.title, notification.body, platformChannelSpecifics);
  }
}
