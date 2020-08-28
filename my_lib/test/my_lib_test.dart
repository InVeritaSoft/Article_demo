import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_lib/my_lib.dart';

void main() {
  const MethodChannel channel = MethodChannel('my_lib');

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
    expect(await MyLib.platformVersion, '42');
  });
}
