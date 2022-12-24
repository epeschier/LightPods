import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Pod {
  final BluetoothDevice device;

  Pod({required this.device});

  String get name => device.name;

  String get id => device.id.toString();

  late List<BluetoothService> _services;
  late BluetoothCharacteristic _lightCharacteristic;
  late BluetoothCharacteristic _buttonCharacteristic;

  void discoverServices() async {
    print('Run discover services for $id');

    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    flutterBlue.stopScan();

    try {
      await device.connect();
    } on PlatformException catch (e) {
      if (e.code != 'already_connected') {
        print('already_connected');
        rethrow;
      }
    } finally {
      _services = await device.discoverServices();
    }
  }

  void getAllCharacteristics() {
    for (BluetoothService service in _services) {
      _getCharacteristics(service);
    }
  }

  void _getCharacteristics(BluetoothService service) {
    print('getCharacteristics for service: ${service.toString()}');
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      print('-- charactersitic: ${characteristic.toString()}');
    }
  }

  void setLight(Color color) {
    Uint8List bytes = _colorToBytes(color);
    _lightCharacteristic.write(bytes);
  }

  Uint8List _colorToBytes(Color color) {
    return Uint8List.fromList([color.red, color.green, color.blue, 12]);
  }

  void listenForButton() {
    _buttonCharacteristic.value.listen((value) {
      print('button pressed for $id');
    });
  }
}
