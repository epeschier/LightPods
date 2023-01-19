import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDeviceService extends ChangeNotifier {
  final List<BluetoothDevice> devices = <BluetoothDevice>[];

  void scanForDevices() {
    devices.clear();
    notifyListeners();

    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        // TODO: check wat er gebeurt als disconnect
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    flutterBlue.startScan();
  }

  void _addDeviceTolist(final BluetoothDevice device) {
    if (!devices.contains(device) && device.name == 'Lightpod') {
      devices.add(device);
      notifyListeners();
    }
  }
}
