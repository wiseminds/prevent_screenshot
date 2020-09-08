import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prevent_screenshot/prevent_screenshot.dart';

void main() {
  const MethodChannel channel = MethodChannel('prevent_screenshot');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PreventScreenshot.platformVersion, '42');
  });
}
