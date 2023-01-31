import 'package:flutter/material.dart';

import '../../../components/checked_color_bullets.dart';
import '../../../models/pod_colors.dart';
import 'activity_setting_container.dart';

class PlayerColorSetting extends StatelessWidget {
  final PodColors colors;
  final List<int> selectedColorIndex;
  final String text;
  final String? subText;
  final IconData icon;
  final Function? onValueChanged;

  const PlayerColorSetting(
      {super.key,
      required this.selectedColorIndex,
      required this.text,
      this.subText,
      required this.icon,
      required this.colors,
      this.onValueChanged});

  @override
  Widget build(BuildContext context) =>
      _getPlayerColors(selectedColorIndex, text);

  Widget _getPlayerColors(List<int> playerColor, String name) {
    return ActivitySettingContainer(
      icon: icon,
      text: name,
      subText: subText,
      widget: CheckedColorBullets(
          colors: _getPlayerColorList(playerColor),
          onValueChanged: (list) => _onColorListChanged(playerColor, list)),
    );
  }

  List<ColorSelection> _getPlayerColorList(List<int> playerColor) {
    List<ColorSelection> list = [];
    for (int i = 0; i < colors.size(); i++) {
      var isSelected = playerColor.any((element) => element == i);
      list.add(ColorSelection(colors.getColor(i), isSelected));
    }
    return list;
  }

  void _onColorListChanged(List<int> playerColor, List<ColorSelection> list) {
    var indexList = _mapColorSelectionToSelectList(list);
    onValueChanged?.call(indexList);
  }

  List<int> _mapColorSelectionToSelectList(
      List<ColorSelection> colorSelectionList) {
    List<int> list = [];
    for (var i = 0; i < colorSelectionList.length; i++) {
      if (colorSelectionList[i].selected) {
        list.add(i);
      }
    }
    return list;
  }
}
