import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Pod {
  final BluetoothDevice device;

  Pod({required this.device});

  Function? onHit;

  String get name => device.name;

  String get id => device.id.toString();

  late List<BluetoothService> _services;
  late BluetoothCharacteristic _lightCharacteristic;
  late BluetoothCharacteristic _buttonCharacteristic;

  void initialize() {
    _discoverServices();
  }

  void _discoverServices() async {
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
      _getAllCharacteristics();
    }
  }

  void _getAllCharacteristics() {
    for (BluetoothService service in _services) {
      _getCharacteristics(service);
    }
  }

  void _getCharacteristics(BluetoothService service) {
    print('getCharacteristics for service: ${service.toString()}');
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      print('-- characteristic: ${characteristic.toString()}');
      if (_isLedCharacteristic(characteristic.uuid)) {
        _lightCharacteristic = characteristic;
      }
      if (_isButtonCharacteristic(characteristic.uuid)) {
        _buttonCharacteristic = characteristic;
      }
    }
  }

  /* Nordic Led-Button Service (LBS)
  * LBS Service: 00001523-1212-EFDE-1523-785FEABCD123
  * LBS Button : 00001524-1212-EFDE-1523-785FEABCD123
  * LBS LED    : 00001525-1212-EFDE-1523-785FEABCD123
  */
  bool _isLedCharacteristic(Guid uuid) =>
      uuid == Guid('00001525-1212-EFDE-1523-785FEABCD123');

  bool _isButtonCharacteristic(Guid uuid) =>
      uuid == Guid('00001524-1212-EFDE-1523-785FEABCD123');

  void setLight(Color color) {
    Uint8List bytes = _colorToBytes(color);
    print('Set light for: $id to ${bytes.toString()}');
    _lightCharacteristic.write(bytes);
  }

  void lightOff() => setLight(Colors.black);

  Uint8List _colorToBytes(Color color) {
    return Uint8List.fromList([color.red, color.green, color.blue, 12]);
  }

  void listenForButton() {
    _buttonCharacteristic.value.listen((value) {
      if (onHit != null) {
        print('button pressed for $id');
        onHit!();
      }
    });
  }
}
