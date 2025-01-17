// Autogenerated from Pigeon (v22.7.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import, no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:push/src/serialization/push_api.dart';

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is UNAuthorizationStatus) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is UNAlertStyle) {
      buffer.putUint8(130);
      writeValue(buffer, value.index);
    } else if (value is UNNotificationSetting) {
      buffer.putUint8(131);
      writeValue(buffer, value.index);
    } else if (value is UNShowPreviewsSetting) {
      buffer.putUint8(132);
      writeValue(buffer, value.index);
    } else if (value is RemoteMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is Notification) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is UNNotificationSettings) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : UNAuthorizationStatus.values[value];
      case 130:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : UNAlertStyle.values[value];
      case 131:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : UNNotificationSetting.values[value];
      case 132:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : UNShowPreviewsSetting.values[value];
      case 133:
        return RemoteMessage.decode(readValue(buffer)!);
      case 134:
        return Notification.decode(readValue(buffer)!);
      case 135:
        return UNNotificationSettings.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
