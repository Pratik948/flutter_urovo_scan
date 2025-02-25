import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_urovo_scan_method_channel.dart';

abstract class FlutterUrovoScanPlatform extends PlatformInterface {
  /// Constructs a FlutterUrovoScanPlatform.
  FlutterUrovoScanPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUrovoScanPlatform _instance = MethodChannelFlutterUrovoScan();

  /// The default instance of [FlutterUrovoScanPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUrovoScan].
  static FlutterUrovoScanPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUrovoScanPlatform] when
  /// they register themselves.
  static set instance(FlutterUrovoScanPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

  Future<String?> getScannerState() {
    throw UnimplementedError('getScannerState() has not been implemented.');
  }

  Future<String?> openScanner() {
    throw UnimplementedError('openScanner() has not been implemented.');
  }

  Future<String?> closeScanner() {
    throw UnimplementedError('closeScanner() has not been implemented.');
  }

  Future<int?> getOutputMode() {
    throw UnimplementedError('getOutputMode() has not been implemented.');
  }

  Future<String?> setOutputMode(int outputMode) {
    throw UnimplementedError('setOutputMode() has not been implemented.');
  }

  Future<String?> getTriggerMode() {
    throw UnimplementedError('getTriggerMode() has not been implemented.');
  }

  Future<String?> setTriggerMode(String mode) {
    throw UnimplementedError('setTriggerMode() has not been implemented.');
  }

  Future<String?> getParamsInts() {
    throw UnimplementedError('getParamsInts() has not been implemented.');
  }

  Future<String?> startDecode() {
    throw UnimplementedError('startDecode() has not been implemented.');
  }

  Future<String?> stopDecode() {
    throw UnimplementedError('stopDecode() has not been implemented.');
  }
}
