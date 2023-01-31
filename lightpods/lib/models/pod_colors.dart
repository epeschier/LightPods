import 'dart:math';

import 'package:flutter/material.dart';

abstract class PodColorService {
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

  static PodColors hitColors = PodColors(_hitColors);
  static PodColors distractingColors = PodColors(_distractingColors);
}

class PodColors {
  final List<Color> colors;

  PodColors(this.colors);

  List<Color> get getColors => colors;

  int size() => colors.length;

  Iterable<Color> getNumColors(int num) => colors.take(num);

  Iterable<Color> getColorsFromIndexes(List<int> indexes) =>
      indexes.map((e) => getColor(e));

  Color getColor(int index) => colors[index];

  Color getRandomColor(int max) => _getRandomItemFromList(max, getColors);

  Color getRandomColorFromIndexList(List<int> selectedColorIndex) {
    var index = Random().nextInt(selectedColorIndex.length);
    return getColor(index);
  }

  Color _getRandomItemFromList(int max, List<Color> list) {
    var index = Random().nextInt(max);
    return list[index];
  }
}
