import 'package:flutter/material.dart';

abstract class PodBase {
  Function? onHit;
  String get id;
  void setLight(Color color);
  void lightOff();
}
