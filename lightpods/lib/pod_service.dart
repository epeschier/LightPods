import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class PodService extends ChangeNotifier {
  final List<BluetoothDevice> devices = <BluetoothDevice>[];

  String get something {
    return 'x';
  }

  void test() {
    devices.add(BluetoothDevice.fromId('x'));
    notifyListeners();
  }

  void scanForDevices() {
    print('Start device scan');

    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
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

/* Nordic Led-Button Service (LBS)
 * LBS Service: 00001523-1212-EFDE-1523-785FEABCD123
 * LBS Button : 00001524-1212-EFDE-1523-785FEABCD123
 * LBS LED    : 00001525-1212-EFDE-1523-785FEABCD123
 */
  void _addDeviceTolist(final BluetoothDevice device) {
    if (!devices.contains(device)) {
      print('Add device: ${device.toString()}');
      devices.add(device);
      notifyListeners();
    }
  }
}
