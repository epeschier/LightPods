import 'package:flutter/material.dart';

import '../../components/toggle_options.dart';
import '../../theme/theme.dart';
import 'activity_setting/activity_description_heading.dart';

class MultipleChoice extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subText;
  final List<String> values;
  final Widget? subWidget;
  final Function onItemSelected;
  final String? valueDescription;
  int selectedItem;

  MultipleChoice(
      {super.key,
      required this.icon,
      required this.text,
      required this.values,
      this.subWidget,
      this.subText,
      this.valueDescription,
      required this.selectedItem,
      required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: ThemeColors.backgroundColor,
        // margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.all(8.0),
        child: Column(children: _buildWidgetList()));
  }

  List<Widget> _buildWidgetList() {
    var list = [
      ActivityDescriptionHeading(
        value: valueDescription,
        icon: icon,
        text: text,
        subText: subText,
      ),
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
        selectedItem: selectedItem,
        onClick: onItemSelected,
      );
}
