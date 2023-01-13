import 'package:flutter/material.dart';
import 'activity_description_heading.dart';

import '../../theme/theme.dart';

class ActivitySettingContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final Widget widget;
  final Widget? subWidget;

  const ActivitySettingContainer(
      {super.key,
      required this.icon,
      required this.text,
      required this.widget,
      this.subWidget,
      this.subText});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: ThemeColors.backgroundColor,
        padding: const EdgeInsets.all(8.0),
        //margin: const EdgeInsets.only(bottom: 2),
        child: Column(children: _buildWidgetList()));
  }

  List<Widget> _buildWidgetList() {
    var list = [_getMainRow()];

    if (subWidget != null) {
      list.add(subWidget!);
    }
    return list;
  }

  Widget _getMainRow() {
    List<Widget> list = [_getIconAndLabel(), widget];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }

  Widget _getIconAndLabel() => Expanded(
          child: ActivityDescriptionHeading(
        icon: icon,
        text: text,
        subText: subText,
      ));
}
