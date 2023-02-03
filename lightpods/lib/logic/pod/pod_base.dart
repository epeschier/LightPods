import 'package:flutter/material.dart';

abstract class PodBase {
  Function? onHit;
  Function? onConnectionChanged;

  String get id;
  String get name;

  bool _connected = false;
  bool get isConnected => _connected;

  bool _state = false;
  bool get isOn => _state;

  void setLight(Color color) => _state = true;
  void lightOff() => _state = false;

  void setBrightness(int value);
  void setSensitivity(int value);
  void playEndGame(Color color);

  void connect() {
    _connected = true;
  }

  void disconnect() {
    _connected = false;
    print("##### $id connected: $isConnected");
  }
}
