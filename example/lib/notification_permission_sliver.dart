import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:push/push.dart';
import 'package:push_example/text_row.dart';

class NotificationPermissionSliver extends HookWidget {
  const NotificationPermissionSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationSettingsIos = useState<UNNotificationSettings?>(null);
    final areNotificationsEnabledAndroid = useState<bool?>(null);
    useEffect(() {
      if (Platform.isIOS) {
        Push.instance
            .getNotificationSettings()
            .then((settings) => notificationSettingsIos.value = settings);
      } else if (Platform.isAndroid) {
        Push.instance.areNotificationsEnabled().then(
            (areNotificationsEnabled) =>
                areNotificationsEnabledAndroid.value = areNotificationsEnabled);
      }

      return () {};
    }, []);

    Widget buildNotificationSettingsSliver() {
      if (Platform.isIOS) {
        final settings = notificationSettingsIos.value;
        if (settings == null) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextRow("Authorization status",
                settings.authorizationStatus.toString()),
            TextRow("Sound settings", settings.soundSetting.toString()),
            TextRow("Badge setting", settings.badgeSetting.toString()),
            TextRow("Alert setting", settings.alertSetting.toString()),
            TextRow("Notification Center setting",
                settings.notificationCenterSetting.toString()),
            TextRow(
                "Lock Screen setting", settings.lockScreenSetting.toString()),
            TextRow("CarPlay setting", settings.carPlaySetting.toString()),
            TextRow("Alert style", settings.alertStyle.toString()),
            TextRow("Show Previews setting",
                settings.showPreviewsSetting.toString()),
            TextRow("Critical Alert setting",
                settings.criticalAlertSetting.toString()),
            TextRow("Provides App Notification settings",
                settings.providesAppNotificationSettings.toString()),
            TextRow("Announcement setting",
                settings.announcementSetting.toString()),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextRow("Enabled", areNotificationsEnabledAndroid.value.toString()),
          ],
        );
      }
    }

    Widget buildRequestPermissionsSliver(BuildContext context,
        ValueNotifier<UNNotificationSettings?> notificationSettings) {
      if (!Platform.isIOS && !Platform.isMacOS && !Platform.isAndroid) {
        return buildNoPermissionsNeededSliver();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            child: const Text("Request Permission"),
            onPressed: () async {
              final isGranted = await Push.instance.requestPermission();
              debugPrint("Push permission granted: $isGranted");
              if (Platform.isIOS) {
                notificationSettings.value =
                    await Push.instance.getNotificationSettings();
              } else if (Platform.isAndroid) {
                areNotificationsEnabledAndroid.value = isGranted;
              }
            },
          ),
          Text(
            "Current permissions:",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          buildNotificationSettingsSliver()
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Permissions',
              style: Theme.of(context).textTheme.headlineMedium),
          buildRequestPermissionsSliver(context, notificationSettingsIos),
        ],
      ),
    );
  }

  Widget buildNoPermissionsNeededSliver() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
            "This platform is not supported yet. Only iOS, macOS and Android are supported."),
      ],
    );
  }
}
