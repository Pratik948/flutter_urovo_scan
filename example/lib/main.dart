import 'package:flutter/material.dart';
import 'dart:async';

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
  final _flutterUrovoScanPlugin = FlutterUrovoScan();
  StreamSubscription? streamSubscription;
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

    _getScannerState();
    _getOutputMode();
    _startListening();
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
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

  Future<void> _startListening() async {
    ScannerListener.startListening();
    streamSubscription = ScannerListener.scanStream.listen(
      (event) {
        setState(() {
          debugPrint('[TEST] startListening $event');
          scanResult = event;
        });
      },
    );
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Scanner State: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      scannerState,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isScannerActive() ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
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

  bool _isScannerActive() {
    if (scannerState == 'ACTIVE') {
      return true;
    }

    return false;
  }
}
