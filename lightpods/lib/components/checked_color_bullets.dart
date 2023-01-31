import 'package:flutter/material.dart';

import '../theme/theme.dart';

class ColorSelection {
  late Color color;
  late bool selected = false;

  ColorSelection(this.color, this.selected);
}

class CheckedColorBullets extends StatefulWidget {
  final List<ColorSelection> colors;
  Function? onValueChanged;

  CheckedColorBullets({super.key, required this.colors, this.onValueChanged});

  @override
  State<CheckedColorBullets> createState() => _CheckedColorBulletsState();
}

class _CheckedColorBulletsState extends State<CheckedColorBullets> {
  @override
  Widget build(BuildContext context) => _getColorBullets(widget.colors);

  Widget _getColorBullets(List<ColorSelection> colors) {
    List<Widget> list = [];
    for (var i = 0; i < colors.length; i++) {
      list.add(_getColorCheckButton(colors[i].color, colors[i].selected, i));
    }
    return Row(children: list);
  }

  Widget _getColorCheckButton(Color color, bool selected, int index) =>
      ElevatedButton(
          onPressed: () => _handleColorClick(index),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(2),
              shape: const CircleBorder(),
              backgroundColor: color),
          child: Visibility(
            visible: selected,
            child: Icon(
              Icons.check,
              color: ThemeColors.backgroundColor,
            ),
          ));

  void _handleColorClick(int index) {
    setState(() {
      widget.colors[index].selected = !widget.colors[index].selected;
    });
    widget.onValueChanged?.call(widget.colors);
  }
}
