import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:push/push.dart';
import 'package:push_example/text_row.dart';

class NotificationPermissionSliver extends HookWidget {
  const NotificationPermissionSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationSettings = useState<UNNotificationSettings?>(null);
    useEffect(() {
      if (Platform.isIOS) {
        Push.instance
            .getNotificationSettings()
            .then((settings) => notificationSettings.value = settings);
      }
    }, []);

    Widget buildNotificationSettingsSliver(UNNotificationSettings? settings) {
      if (settings == null) {
        return const SizedBox.shrink();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextRow(
              "Authorization status", settings.authorizationStatus.toString()),
          TextRow("Sound settings", settings.soundSetting.toString()),
          TextRow("Badge setting", settings.badgeSetting.toString()),
          TextRow("Alert setting", settings.alertSetting.toString()),
          TextRow("Notification Center setting",
              settings.notificationCenterSetting.toString()),
          TextRow("Lock Screen setting", settings.lockScreenSetting.toString()),
          TextRow("CarPlay setting", settings.carPlaySetting.toString()),
          TextRow("Alert style", settings.alertStyle.toString()),
          TextRow(
              "Show Previews setting", settings.showPreviewsSetting.toString()),
          TextRow("Critical Alert setting",
              settings.criticalAlertSetting.toString()),
          TextRow("Provides App Notification settings",
              settings.providesAppNotificationSettings.toString()),
          TextRow(
              "Announcement setting", settings.announcementSetting.toString()),
        ],
      );
    }

    Widget buildRequestPermissionsSliver(BuildContext context,
        ValueNotifier<UNNotificationSettings?> notificationSettings) {
      if (Platform.isIOS) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                "Since this iOS, you need permission to show notifications to the user"),
            TextButton(
              child: const Text("Request Permission"),
              onPressed: () async {
                final isGranted = await Push.instance.requestPermission();
                debugPrint("Push permission granted: $isGranted");
                notificationSettings.value =
                await Push.instance.getNotificationSettings();
              },
            ),
            Text(
              "Current permissions:",
              style: Theme.of(context).textTheme.headline5,
            ),
            buildNotificationSettingsSliver(notificationSettings.value)
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text("No permissions are needed on this platform."),
          ],
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Permissions', style: Theme.of(context).textTheme.headline4),
          buildRequestPermissionsSliver(context, notificationSettings),
        ],
      ),
    );
  }
}
