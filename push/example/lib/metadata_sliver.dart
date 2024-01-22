import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:push/push.dart';
import 'package:push_example/use_push_token.dart';
import 'package:share_plus/share_plus.dart';

class MetadataSliver extends HookWidget {
  const MetadataSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pushToken = usePushToken();
    final shareButtonGlobalKey = GlobalKey();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Push Token', style: Theme.of(context).textTheme.headline4),
          Row(
            children: [
              TextButton(
                child: const Text("Get token"),
                onPressed: () async {
                  // Not necessary on Android if you subscribe to `onNewTokenSubscription`, since FCM
                  // will provide the token as soon as you call deleteToken.
                  pushToken.value = await Push.instance.token;
                },
              ),
              TextButton(
                child: const Text("Delete token"),
                onPressed: () async {
                  await Push.instance.deleteToken();
                  pushToken.value = "";
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                key: shareButtonGlobalKey,
                icon: const Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                onPressed: () {
                  print("The push token is: ${pushToken.value}");
                  final box = shareButtonGlobalKey.currentContext
                      ?.findRenderObject() as RenderBox;
                  final position = box.localToGlobal(Offset.zero);
                  final rect =
                      Rect.fromLTWH(position.dx, position.dy, 200, 200);
                  Share.share(pushToken.value ?? "Error: no token was found",
                      sharePositionOrigin: rect);
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
