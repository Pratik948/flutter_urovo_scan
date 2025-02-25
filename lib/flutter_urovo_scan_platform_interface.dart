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
}
