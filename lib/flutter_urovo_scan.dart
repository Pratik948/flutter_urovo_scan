
import 'flutter_urovo_scan_platform_interface.dart';

class FlutterUrovoScan {
  Future<String?> getPlatformVersion() {
    return FlutterUrovoScanPlatform.instance.getPlatformVersion();
  }
}
