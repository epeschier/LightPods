import 'package:flutter/material.dart';

import 'color_bullets.dart';

class ColorIndicator extends StatefulWidget {
  final String text;
  final List<Color> colors;

  const ColorIndicator({super.key, required this.colors, required this.text});

  @override
  State<ColorIndicator> createState() => _ColorIndicatorState();
}

class _ColorIndicatorState extends State<ColorIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(widget.text),
      ColorBullets(colors: widget.colors, size: 22),
    ]);
  }
}
