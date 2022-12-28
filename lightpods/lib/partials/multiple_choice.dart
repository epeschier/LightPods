import 'package:flutter/material.dart';

import '../components/toggle_options.dart';
import '../theme/theme.dart';

class MultipleChoice extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final List<String> values;
  final Widget? subWidget;
  final Function onItemSelected;

  const MultipleChoice(
      {super.key,
      required this.icon,
      required this.text,
      required this.values,
      this.subWidget,
      this.subText,
      required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ThemeColors.backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        child: Column(children: _buildWidgetList()));
  }

  List<Widget> _buildWidgetList() {
    var list = [
      _getIconAndLabel(),
      const SizedBox(height: 10),
      _getMultipleChoice(),
      const SizedBox(height: 5),
    ];

    if (subWidget != null) {
      list.add(subWidget!);
    }
    return list;
  }

  Widget _getMultipleChoice() => ToggleOptions(
        values: values,
        selectedItem: 0,
        onClick: onItemSelected,
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
