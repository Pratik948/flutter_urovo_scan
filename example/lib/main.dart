import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_urovo_scan/flutter_urovo_scan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterUrovoScanPlugin = FlutterUrovoScan();
  String scannerState = '';
  String scanResult = 'Waiting for result...';
  int selectedOutputMode = 1;

  List<int> outModeOptions = [
    0, // Intent
    1, // Textbox focus
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();

    _getScannerState();

    // Listen to Urovo Scanner
    _startListening();

    _getOutputMode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterUrovoScanPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _startListening() async {
    ScannerListener.startListening();
    ScannerListener.scanStream.listen(
      (event) {
        setState(() {
          debugPrint('[TEST] startListening 2 $event');
          scanResult = event;
        });
      },
    );
  }

  Future<void> _getScannerState() async {
    final result = await _flutterUrovoScanPlugin.getScannerState();
    setState(() {
      scannerState = result ?? '';
    });
  }

  Future<void> _getOutputMode() async {
    final result = await _flutterUrovoScanPlugin.getOutputMode();
    setState(() {
      selectedOutputMode = result ?? 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Running on: $_platformVersion\n'),
                Text('Scanner State: $scannerState'),
                const SizedBox(height: 16),

                // Open Scanner
                ElevatedButton(
                  onPressed: () async {
                    final result = await _flutterUrovoScanPlugin.openScanner();
                    setState(() {
                      scannerState = result ?? '';
                    });
                  },
                  child: const Text('Open Scanner'),
                ),
                const SizedBox(height: 16),

                // Close Scanner
                ElevatedButton(
                  onPressed: () async {
                    final result = await _flutterUrovoScanPlugin.closeScanner();
                    setState(() {
                      scannerState = result ?? '';
                    });
                  },
                  child: const Text('Close Scanner'),
                ),
                const SizedBox(height: 16),

                SegmentedButton(
                  multiSelectionEnabled: false,
                  segments: const [
                    ButtonSegment(
                      value: 0,
                      label: Text('Intent'),
                    ),
                    ButtonSegment(
                      value: 1,
                      label: Text('Textbox focus'),
                    ),
                  ],
                  selected: {selectedOutputMode}, // Current selected value
                  onSelectionChanged: (newSelection) async {
                    setState(() {
                      selectedOutputMode = newSelection.first;
                    });
                    await _flutterUrovoScanPlugin
                        .setOutputMode(selectedOutputMode);
                  },
                ),
                const SizedBox(height: 16),

                // Scanner Result
                const Text('Scanner Result'),

                // Scanner Result Intent
                if (selectedOutputMode == 0)
                  Text(
                    scanResult,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                // Scanner Result Textbox
                if (selectedOutputMode == 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: TextField(
                      autofocus: true,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
