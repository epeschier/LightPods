import 'package:flutter/material.dart';

class ColorBullets extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const ColorBullets({super.key, required this.colors, required this.size});

  @override
  Widget build(BuildContext context) => _getColorBullets(colors);

  Widget _getColorBullets(List<Color> colors) {
    List<Widget> list = [];
    for (var color in colors) {
      list.add(_colorBullet(color));
    }
    return Row(children: list);
  }

  Widget _colorBullet(Color color) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Icon(
          Icons.circle,
          size: size,
          color: color,
        ));
  }
}
