import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:push/push.dart';

class DarwinRegisterUnregisterWidget extends HookWidget {
  const DarwinRegisterUnregisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tooltip(
          message:
              'Darwin includes all apple platforms, including iOS, iPadOS, macOS, watchOS, and tvOS',
          child: Text('Darwin only (register/unregister)',
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        Row(
          children: [
            TextButton(
              child: const Text("Register"),
              onPressed: () {
                Push.instance.registerForRemoteNotifications();
              },
            ),
            TextButton(
              child: const Text("Unregister"),
              onPressed: () {
                Push.instance.unregisterForRemoteNotifications();
              },
            ),
          ],
        )
      ],
    );
  }
}
