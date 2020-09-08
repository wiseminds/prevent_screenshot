
import 'dart:async';

import 'package:flutter/services.dart';

class PreventScreenshot {
  static const MethodChannel _channel =
      const MethodChannel('prevent_screenshot');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
