import 'package:flutter/material.dart';

import '../../../components/slider_input.dart';
import '../../../models/strike_out.dart';
import '../multiple_choice.dart';

class StrikeOutSetting extends StatefulWidget {
  final StrikeOut value;

  const StrikeOutSetting({super.key, required this.value});

  @override
  State<StrikeOutSetting> createState() => _StrikeOutSettingState();
}

class _StrikeOutSettingState extends State<StrikeOutSetting> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = (widget.value.value ? 1 : 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _getStrikeOutOption();

  Widget _getStrikeOutOption() => MultipleChoice(
        icon: Icons.logout,
        text: 'Strike out',
        subText:
            'The number of strikes (false hits) until the activity will stop',
        valueDescription: widget.value.toString(),
        selectedItem: _selectedIndex,
        onItemSelected: _onMultipleChoiceChanged,
        values: const ['No', 'Yes'],
        subWidget: (_selectedIndex > 0)
            ? SliderInput(
                value: widget.value.count.toDouble(),
                max: 100,
                decimals: 0,
                onValueChanged: (double value) {
                  setState(() {
                    widget.value.count = value.toInt();
                  });
                },
              )
            : null,
      );

  void _onMultipleChoiceChanged(int index) {
    widget.value.value = (index == 1);
    setState(() {
      _selectedIndex = index;
    });
  }
}
