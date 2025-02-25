import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_urovo_scan/flutter_urovo_scan.dart';
import 'package:flutter_urovo_scan/flutter_urovo_scan_platform_interface.dart';
import 'package:flutter_urovo_scan/flutter_urovo_scan_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUrovoScanPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUrovoScanPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterUrovoScanPlatform initialPlatform = FlutterUrovoScanPlatform.instance;

  test('$MethodChannelFlutterUrovoScan is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUrovoScan>());
  });

  test('getPlatformVersion', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.getPlatformVersion(), '42');
  });
}
