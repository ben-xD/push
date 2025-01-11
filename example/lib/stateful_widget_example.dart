import 'package:flutter/material.dart';
import 'package:push/push.dart';

class ExamplePushStatefulWidget extends StatefulWidget {
  const ExamplePushStatefulWidget({super.key});

  @override
  ExamplePushState createState() => ExamplePushState();
}

class ExamplePushState extends State<ExamplePushStatefulWidget> {
  VoidCallback? unsubscribeOnMessage;

  @override
  void initState() {
    super.initState();
    unsubscribeOnMessage = Push.instance.addOnMessage((message) {
      print('Stateful widget received message');
    });
  }

  @override
  void dispose() {
    unsubscribeOnMessage?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Text('[StatefulWidget] Logging push notifications...');
  }
}
