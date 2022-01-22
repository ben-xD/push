import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:push_example/use_push_token.dart';
import 'package:share_plus/share_plus.dart';

class MetadataSliver extends HookWidget {
  const MetadataSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pushToken = usePushToken();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Push Token', style: Theme.of(context).textTheme.headline4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                onPressed: () {
                  print("The push token is: ${pushToken.value}");
                  Share.share("${pushToken.value}");
                },
              ),
              Expanded(child: Text(pushToken.value.toString()))
            ],
          ),
        ],
      ),
    );
  }
}
