import 'package:flutter/material.dart';
import 'package:lightpods/theme/theme.dart';

class ColorIndicator extends StatefulWidget {
  final int numberOfColors;
  final int playerNumber;

  const ColorIndicator(
      {super.key, required this.numberOfColors, required this.playerNumber});

  @override
  State<ColorIndicator> createState() => _ColorIndicatorState();
}

class _ColorIndicatorState extends State<ColorIndicator> {
  List<Widget> getColorBullets(int number) {
    List<Widget> list = [];
    for (var i = 0; i < widget.numberOfColors; i++) {
      list.add(_colorBullet(PodColors.palette[widget.playerNumber][i]));
    }
    return list;
  }

  Widget _colorBullet(Color color) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          Icons.circle,
          size: 20,
          color: color,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: getColorBullets(widget.numberOfColors));
  }
}
