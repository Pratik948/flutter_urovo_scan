import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_urovo_scan_platform_interface.dart';

/// An implementation of [FlutterUrovoScanPlatform] that uses method channels.
class MethodChannelFlutterUrovoScan extends FlutterUrovoScanPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_urovo_scan');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
