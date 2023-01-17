import 'package:flutter/material.dart';

abstract class PodBase {
  Function? onHit;
  String get id;
  String get name;

  bool _connected = false;
  bool get isConnected => _connected;

  void setLight(Color color);
  void lightOff();
  void setBrightness(int value);
  void setSensitivity(int value);
  void playEndGame(Color color);

  void connect() {
    _connected = true;
  }

  void disconnect() {
    _connected = false;
  }
}
