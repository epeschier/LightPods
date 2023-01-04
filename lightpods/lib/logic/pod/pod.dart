import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'pod_base.dart';

class Pod extends PodBase {
  final BluetoothDevice device;

  Pod({required this.device});

  @override
  String get name =>
      '${device.name} ${_numberFromUuid(id).toString().padLeft(3, '0')}';

  @override
  String get id => device.id.toString();

  bool _isOn = false;

  bool get isOn => _isOn;

  late List<BluetoothService> _services;
  late BluetoothCharacteristic _lightCharacteristic;
  late BluetoothCharacteristic _buttonCharacteristic;

  @override
  void connect() {
    _discoverServices();
  }

  @override
  void disconnect() {
    device.disconnect();
  }

  void _discoverServices() async {
    //   print('Run discover services for $id');

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
//    print('getCharacteristics for service: ${service.toString()}');
    for (BluetoothCharacteristic characteristic in service.characteristics) {
//      print('-- characteristic: ${characteristic.toString()}');
      if (_isLedCharacteristic(characteristic.uuid)) {
        _lightCharacteristic = characteristic;
      }
      if (_isButtonCharacteristic(characteristic.uuid)) {
        _buttonCharacteristic = characteristic;
        _listenForButton();
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

  @override
  void setLight(Color color) {
    Uint8List bytes = _colorToBytes(color);
    _lightCharacteristic.write(bytes);
    _isOn = (color != Colors.black);
  }

  Uint8List _colorToBytes(Color color) =>
      Uint8List.fromList([color.red, color.green, color.blue, 0]);

  @override
  void lightOff() {
    if (_isOn) {
      setLight(Colors.black);
    }
  }

  static const _brightnessCommand = 0x01;
  static const _endGameCommand = 0x02;
  static const _sensitivityCommand = 0x03;

  @override
  void setBrightness(int value) {
    Uint8List command = Uint8List.fromList([value, 0, 0, _brightnessCommand]);
    _lightCharacteristic.write(command);
  }

  @override
  void setSensitivity(int value) {
    Uint8List command =
        Uint8List.fromList([value & 0xff, value >> 8, 0, _sensitivityCommand]);
    _lightCharacteristic.write(command);
  }

  @override
  void playEndGame(Color color) {
    var command = _colorToBytes(color);
    command[3] = _endGameCommand;
    print(command);
    //_lightCharacteristic.write(command);
  }

  void _listenForButton() {
    _buttonCharacteristic.value.listen((value) {
      onHit?.call();
    });
    _buttonCharacteristic.setNotifyValue(true);
  }

  int _numberFromUuid(String uuid) {
    int number = 0;
    for (int i = 0; i < uuid.length; i++) {
      var char = uuid[i];
      if (_isHexChar(char)) {
        number += int.parse(char, radix: 16);
      }
    }

    if (number == 0) {
      return 0;
    }
    return number % 1000;
  }

  bool _isHexChar(String char) {
    const validChars = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F'
    ];
    return validChars.contains(char.toUpperCase());
  }
}
