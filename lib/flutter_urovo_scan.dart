import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_urovo_scan_platform_interface.dart';

class FlutterUrovoScan {
  Future<String?> getPlatformVersion() {
    return FlutterUrovoScanPlatform.instance.getPlatformVersion();
  }

  Future<String?> getBatteryLevel() {
    return FlutterUrovoScanPlatform.instance.getBatteryLevel();
  }

  Future<String?> getScannerState() {
    return FlutterUrovoScanPlatform.instance.getScannerState();
  }

  Future<String?> openScanner() {
    return FlutterUrovoScanPlatform.instance.openScanner();
  }

  Future<String?> closeScanner() {
    return FlutterUrovoScanPlatform.instance.closeScanner();
  }

  Future<int?> getOutputMode() {
    return FlutterUrovoScanPlatform.instance.getOutputMode();
  }

  Future<String?> setOutputMode(int outputMode) {
    return FlutterUrovoScanPlatform.instance.setOutputMode(outputMode);
  }

  Future<String?> getTriggerMode() {
    return FlutterUrovoScanPlatform.instance.getTriggerMode();
  }

  Future<String?> setTriggerMode(String mode) {
    return FlutterUrovoScanPlatform.instance.setTriggerMode(mode);
  }

  Future<String?> getParamsInts() {
    return FlutterUrovoScanPlatform.instance.getParamsInts();
  }

  Future<String?> startDecode() {
    return FlutterUrovoScanPlatform.instance.startDecode();
  }

  Future<String?> stopDecode() {
    return FlutterUrovoScanPlatform.instance.stopDecode();
  }
}

class ScannerListener {
  static const eventChannel = EventChannel('flutter_urovo_scan_plugin/scan');

  static final StreamController<String> _controller =
      StreamController.broadcast();

  static Stream<String> get scanStream => _controller.stream;

  static void startListening() {
    eventChannel.receiveBroadcastStream().listen(
      (event) {
        _controller.add(event.toString());
      },
      onError: (error) {
        debugPrint('[TEST] startListening Error : $error');
      },
    );
  }
}
