import 'package:flutter/material.dart';

import '../logic/pod/pod_base.dart';

class FakePod extends PodBase {
  final String _id;

  FakePod(this._id);

  Function? onColorUpdated;

  @override
  String get id => _id;

  @override
  void lightOff() {
    print("light off for: $_id");
    onColorUpdated?.call(Colors.grey);
  }

  @override
  void setLight(Color color) {
    onColorUpdated?.call(color);
    print("light on for: $_id - $color");
  }

  void initiateClickCallback() {
    onHit?.call();
  }

  @override
  void playEndGame(Color color) {
    // TODO: implement playEndGame
  }

  @override
  void setBrightness(int value) {
    // TODO: implement setBrightness
  }

  @override
  void setSensitivity(int value) {
    // TODO: implement setSensitivity
  }

  @override
  String get name => "dummy $id";

  @override
  void connect() {
    // TODO: implement connect
  }

  @override
  void disconnect() {
    // TODO: implement disconnect
  }
}
