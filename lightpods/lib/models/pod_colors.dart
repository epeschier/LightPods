import 'dart:math';

import 'package:flutter/material.dart';

abstract class PodColors {
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

  static List<Color> get getHitColors => _hitColors;
  static List<Color> get getDistractingColors => _distractingColors;

  static Iterable<Color> getNumHitColors(int num) => getHitColors.take(num);
  static Iterable<Color> getNumDistractingColors(int num) =>
      getDistractingColors.take(num);

  static Color getHitColor(int index) => _hitColors[index];

  static Color getDistractingColor(int index) => _hitColors[index];

  static Color getRandomHitColor(int max) =>
      _getRandomItemFromList(max, getHitColors);

  static Color getRandomDistractingColor(int max) =>
      _getRandomItemFromList(max, getDistractingColors);

  static Color _getRandomItemFromList(int max, List<Color> list) {
    var index = Random().nextInt(max);
    return list[index];
  }
}
