
import 'dart:async';

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
}
