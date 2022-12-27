import 'package:flutter/material.dart';

import '../theme/theme.dart';

class ActivitySetting extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final Widget widget;
  final Widget? subWidget;

  const ActivitySetting(
      {super.key,
      required this.icon,
      required this.text,
      required this.widget,
      this.subWidget,
      this.subText});

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 80,
        decoration: BoxDecoration(
          color: ThemeColors.backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: Column(children: _buildWidgetList()));
  }

  List<Widget> _buildWidgetList() {
    var list = [_getMainRow()];
    if (subWidget != null) {
      list.add(subWidget!);
    }
    return list;
  }

  Widget _getMainRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Expanded(child: _getIconAndLabel()), widget],
      );

  Widget _getIconAndLabel() => Row(children: [
        Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              size: 40,
            )),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: ThemeColors.headerText,
            ),
            Text(
              subText ?? '',
              style: ThemeColors.subText,
            ),
          ],
        ))
      ]);
}
