import 'package:flutter/material.dart';

import 'pod_base.dart';

class FakePod extends PodBase {
  final String _id;

  FakePod(this._id);

  @override
  String get id => _id;

  @override
  void lightOff() {}

  @override
  void setLight(Color color) {
    print("lighton $color");
  }

  void initiateClickCallback() {
    onHit!();
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
  String get name => "dummy";

  @override
  void connect() {
    // TODO: implement connect
  }

  @override
  void disconnect() {
    // TODO: implement disconnect
  }
}
