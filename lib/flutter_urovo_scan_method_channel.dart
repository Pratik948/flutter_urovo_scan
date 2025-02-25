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
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getBatteryLevel() async {
    final result = await methodChannel.invokeMethod<String>('getBatteryLevel');
    return result;
  }

  @override
  Future<String?> getScannerState() async {
    final result = await methodChannel.invokeMethod<String>('getScannerState');
    return result;
  }

  @override
  Future<String?> openScanner() async {
    final result = await methodChannel.invokeMethod<String>('openScanner');
    return result;
  }

  @override
  Future<String?> closeScanner() async {
    final result = await methodChannel.invokeMethod<String>('closeScanner');
    return result;
  }

  @override
  Future<int?> getOutputMode() async {
    final result = await methodChannel.invokeMethod<int>('getOutputMode');
    return result;
  }

  @override
  Future<String?> setOutputMode(int outputMode) async {
    final result = await methodChannel
        .invokeMethod<String>('setOutputMode', {"output_mode": outputMode});
    return result;
  }

  @override
  Future<String?> getTriggerMode() async {
    final result = await methodChannel.invokeMethod<String>('getTriggerMode');
    return result;
  }

  @override
  Future<String?> setTriggerMode(String mode) async {
    final result = await methodChannel
        .invokeMethod<String>('setTriggerMode', {"mode": mode.toUpperCase()});

    return result;
  }

  @override
  Future<String?> getParamsInts() async {
    final result = await methodChannel.invokeMethod<String>('getParamsInts');
    return result;
  }

  @override
  Future<String?> startDecode() async {
    final result = await methodChannel.invokeMethod<String>('startDecode');
    return result;
  }

  @override
  Future<String?> stopDecode() async {
    final result = await methodChannel.invokeMethod<String>('stopDecode');
    return result;
  }
}
