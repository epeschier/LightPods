import 'package:flutter/material.dart';

class ColorBullets extends StatelessWidget {
  final double? size;
  final List<Color> colors;
  Function? onColorClick;

  ColorBullets(
      {super.key, required this.colors, this.size = 22, this.onColorClick});

  @override
  Widget build(BuildContext context) => _getColorBullets(colors);

  Widget _getColorBullets(List<Color> colors) {
    List<Widget> list = [];
    for (var i = 0; i < colors.length; i++) {
      list.add(_colorBullet(colors[i], i));
    }
    return Row(children: list);
  }

  Widget _colorBullet(Color color, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: InkWell(
          onTap: () => _handleColorClick(index),
          child: Icon(
            Icons.circle,
            size: size,
            color: color,
          ),
        ));
  }

  void _handleColorClick(int index) {
    onColorClick?.call(index);
  }
}
