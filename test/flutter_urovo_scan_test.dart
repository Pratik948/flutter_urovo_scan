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

  @override
  Future<String?> getBatteryLevel() => Future.value('88');

  @override
  Future<String?> openScanner() => Future.value('Scanner is open');

  @override
  Future<String?> closeScanner() => Future.value('Scanner is close');

  @override
  Future<int?> getOutputMode() => Future.value(0);

  @override
  Future<String?> setOutputMode(outputMode) => Future.value('Success');

  @override
  Future<String?> getParamsInts() => Future.value('Success');

  @override
  Future<String?> getScannerState() => Future.value('ON');

  @override
  Future<String?> getTriggerMode() => Future.value('HOST');

  @override
  Future<String?> setTriggerMode(mode) => Future.value('Success');

  @override
  Future<String?> startDecode() => Future.value('Success');

  @override
  Future<String?> stopDecode() => Future.value('Success');
}

void main() {
  final FlutterUrovoScanPlatform initialPlatform =
      FlutterUrovoScanPlatform.instance;

  test('$MethodChannelFlutterUrovoScan is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUrovoScan>());
  });

  test('getPlatformVersion', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.getPlatformVersion(), '42');
  });

  test('getBatteryLevel', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.getBatteryLevel(), '88');
  });
  test('openScanner', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.openScanner(), 'Scanner is open');
  });
  test('closeScanner', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.closeScanner(), 'Scanner is close');
  });
  test('getOutputMode', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.getOutputMode(), 0);
  });
  test('setOutputMode', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.setOutputMode(1), 'Success');
  });
  test('getParamsInts', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.getParamsInts(), 'Success');
  });
  test('getScannerState', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.getScannerState(), 'ON');
  });
  test('getTriggerMode', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.getTriggerMode(), 'HOST');
  });
  test('setTriggerMode', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.setTriggerMode('HOST'), 'Success');
  });
  test('startDecode', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.startDecode(), 'Success');
  });
  test('stopDecode', () async {
    FlutterUrovoScan flutterUrovoScanPlugin = FlutterUrovoScan();
    MockFlutterUrovoScanPlatform fakePlatform = MockFlutterUrovoScanPlatform();
    FlutterUrovoScanPlatform.instance = fakePlatform;

    expect(await flutterUrovoScanPlugin.stopDecode(), 'Success');
  });
}
