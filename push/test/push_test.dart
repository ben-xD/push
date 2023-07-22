import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('stream sadly cannot be turned into broadcast multiple times', () {
    final stream = StreamController<String>().stream;
    final broadcast1 = stream.asBroadcastStream();
    final broadcast2 = stream.asBroadcastStream();

    // Listening to the broadcast and immediately cancels means
    // the second broadcast is useless/erroneous
    broadcast1.listen((event) {}).cancel();

    expect(() {
      broadcast2.listen((event) {});
    }, throwsStateError);
  });

  test('broadcast stream can be subscribed to multiple times', () async {
    final streamController = StreamController<String>();
    final stream = streamController.stream;
    final broadcast = stream.asBroadcastStream();

    final c1 = Completer();
    final c2 = Completer();
    final sub1 = broadcast.listen((event) {
      c1.complete();
    });

    final sub2 = broadcast.listen((event) {
      c2.complete();
    });

    streamController.add("Hello World");

    await c1.future;
    await c2.future;
    sub1.cancel();
    sub2.cancel();
  });
}
