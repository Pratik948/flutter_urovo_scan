import 'dart:async';
import 'dart:io';

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

  /// Retrieves the current state of the Urovo scanner.
  ///
  /// Returns:
  /// - `"ACTIVE"` if the scanner is turned on.
  /// - `"INACTIVE"` if the scanner is turned off.
  Future<String?> getScannerState() {
    return FlutterUrovoScanPlatform.instance.getScannerState();
  }

  /// Opens the Urovo scanner.
  ///
  /// Returns:
  /// - `"ACTIVE"` if the scanner was successfully opened.
  Future<String?> openScanner() {
    return FlutterUrovoScanPlatform.instance.openScanner();
  }

  /// Closes the Urovo scanner.
  ///
  /// Returns:
  /// - `"INACTIVE"` if the scanner was successfully closed.
  Future<String?> closeScanner() {
    return FlutterUrovoScanPlatform.instance.closeScanner();
  }

  /// Retrieves the scanner’s output mode.
  ///
  /// Output modes:
  /// - `0` (Intent Mode): The scan result is returned through `startListening()`.
  /// - `1` (Textbox Focus Mode): The scan result is automatically entered into the active text field.
  ///   - **Note:** In Textbox Focus mode, `startListening()` will not be used.
  ///
  /// Returns:
  /// - `0` for Intent Mode.
  /// - `1` for Textbox Focus Mode.
  Future<int?> getOutputMode() {
    return FlutterUrovoScanPlatform.instance.getOutputMode();
  }

  /// Sets the scanner’s output mode.
  ///
  /// Available modes:
  /// - `0` (Intent Mode): Uses `startListening()` to return scan results.
  /// - `1` (Textbox Focus Mode): Displays the scan result directly in the active text field.
  ///   - **Note:** In Textbox Focus mode, `startListening()` will not be used.
  ///
  /// Parameters:
  /// - [outputMode] The desired output mode (0 for Intent, 1 for Textbox Focus).
  Future<String?> setOutputMode(int outputMode) {
    return FlutterUrovoScanPlatform.instance.setOutputMode(outputMode);
  }

  /// Retrieves the current trigger mode of the scanner.
  ///
  /// Trigger modes:
  /// - `"HOST"`: The scanner is controlled by the host device.
  /// - `"CONTINUOUS"`: The scanner scans continuously.
  /// - `"PULSE"`: The scanner scans with a pulse-based trigger.
  ///
  /// Returns:
  /// - `"HOST"`, `"CONTINUOUS"`, or `"PULSE"` depending on the current setting.
  Future<String?> getTriggerMode() {
    return FlutterUrovoScanPlatform.instance.getTriggerMode();
  }

  /// Sets the scanner's trigger mode.
  ///
  /// Available trigger modes:
  /// - `"HOST"`: Controlled by the host device.
  /// - `"CONTINUOUS"`: Scans continuously.
  /// - `"PULSE"`: Scans with a pulse-based trigger.
  ///
  /// Parameters:
  /// - [mode] The desired trigger mode (`"HOST"`, `"CONTINUOUS"`, or `"PULSE"`).
  Future<String?> setTriggerMode(String mode) {
    return FlutterUrovoScanPlatform.instance.setTriggerMode(mode);
  }

  Future<String?> getParamsInts() {
    return FlutterUrovoScanPlatform.instance.getParamsInts();
  }

  /// Starts the decoding process,
  ///
  /// This function turns on the scanner and begins scanning for barcodes.
  Future<String?> startDecode() {
    return FlutterUrovoScanPlatform.instance.startDecode();
  }

  /// Stops the decoding process.
  ///
  /// This function stops the scanning process.
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
    if (!Platform.isAndroid) {
      throw Exception('Available only for Android');
    }

    try {
      eventChannel.receiveBroadcastStream().listen(
        (event) {
          _controller.add(event.toString());
        },
        onError: (error) {
          debugPrint('[TEST] startListening Error : $error');
        },
      );
    } catch (e) {
      throw Exception('[EventChannelError] ${e.toString()}');
    }
  }
}
