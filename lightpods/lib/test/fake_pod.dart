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
    onColorUpdated?.call(Colors.grey);
    super.lightOff();
  }

  @override
  void setLight(Color color) {
    onColorUpdated?.call(color);
    super.setLight(color);
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
  String get name => "Dummy $id";

  @override
  void connect() {
    // TODO: implement connect
  }

  @override
  void disconnect() {
    // TODO: implement disconnect
  }
}
