import 'package:flutter/material.dart';

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
      getColorBullets(widget.colors),
    ]);
  }

  Widget getColorBullets(List<Color> colors) {
    List<Widget> list = [];
    for (var color in colors) {
      list.add(_colorBullet(color));
    }
    return Row(children: list);
  }

  Widget _colorBullet(Color color) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          Icons.circle,
          size: 24,
          color: color,
        ));
  }
}
