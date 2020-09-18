import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class PreventScreenshot {
  static const MethodChannel _channel =
      const MethodChannel('prevent_screenshot');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> get lockApp async {
    return await _channel.invokeMethod('lock_app');
  }

  static Future<void> get unlockApp async {
    return await _channel.invokeMethod('unlock_app');
  }

  static Stream<bool> _stream;

  static const EventChannel _eventChannel =
      EventChannel('prevent_screenshot.events');

  static Stream<bool> get statusStream {
    if (Platform.isAndroid) return Stream.empty();
    if (_stream == null) {
      _stream = _eventChannel
          .receiveBroadcastStream()
          .map((buffer) => buffer as bool);
    }
    return _stream;
  }
}
