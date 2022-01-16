
import 'dart:async';

import 'package:flutter/services.dart';

class PushIos {
  static const MethodChannel _channel = MethodChannel('push_ios');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
