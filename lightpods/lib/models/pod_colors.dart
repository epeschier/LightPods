import 'dart:math';

import 'package:flutter/material.dart';

class PodColors {
  static const List<Color> _hitColors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
  ];

  static const List<Color> _distractingColors = [
    Colors.orange,
    Color.fromARGB(255, 255, 100, 200),
    Color.fromARGB(255, 161, 2, 185),
    Color.fromARGB(255, 2, 176, 233)
  ];

  final Random _random = Random();

  List<Color> get getHitColors => _hitColors;
  List<Color> get getDistractingColors => _distractingColors;

  Iterable<Color> getNumHitColors(int num) => getHitColors.take(num);
  Iterable<Color> getNumDistractingColors(int num) =>
      getDistractingColors.take(num);

  Color getHitColor(int index) => _hitColors[index];

  Color getDistractingColor(int index) => _hitColors[index];

  Color getRandomHitColor(int max) {
    var index = _random.nextInt(max);
    return _hitColors[index];
  }

  Color getRandomDistractingColor(int max) {
    var index = _random.nextInt(max);
    return _hitColors[index + 4];
  }
}
