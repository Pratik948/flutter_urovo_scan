import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScannerService {
  static const _methodChannel = MethodChannel('flutter_urovo_scan');
  static const _eventChannel = EventChannel('flutter_urovo_scan_plugin/scan');

  static final StreamController<String> _controller =
      StreamController.broadcast();

  static Stream<String> get scanStream => _controller.stream;

  static void startListening() {
    _eventChannel.receiveBroadcastStream().listen(
      (event) {
        debugPrint('[TEST][DEBUG] Received Event: $event');
        if (event is String) {
          _controller.add(event); // Ensure only valid strings are added
          debugPrint('[TEST][Controller add] Received Event: $event');
        } else {
          debugPrint(
              '[TEST][ERROR] Unexpected event type: ${event.runtimeType}');
        }
      },
      onError: (error) {
        debugPrint('[TEST][ERROR] EventChannel Error: $error');
      },
    );
  }

  static Future<String> openScannerFromNative() async {
    String isScannerOpen;
    try {
      final result = await _methodChannel.invokeMethod<bool>('openScanner');
      isScannerOpen = 'Open Scanner Result:\n${result.toString()}';
    } on PlatformException catch (e) {
      isScannerOpen = "[ERROR] Open Scanner Result:\n'${e.message}'.";
    }
    debugPrint('[TEST][LOG] isScannerOpen: $isScannerOpen');
    return isScannerOpen;
  }
}
