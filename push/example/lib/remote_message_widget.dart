import 'package:flutter/material.dart';
import 'package:push/push.dart';
import 'package:push_example/text_row.dart';

class RemoteMessageWidget extends StatelessWidget {
  final RemoteMessage1? remoteMessage;

  const RemoteMessageWidget(this.remoteMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (remoteMessage == null) {
      return const Text("No remote message");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextRow("Title", remoteMessage!.notification?.title.toString()),
          TextRow("Body", remoteMessage!.notification?.body.toString()),
          TextRow("Data", remoteMessage!.data?.toString())
        ],
      ),
    );
  }
}
