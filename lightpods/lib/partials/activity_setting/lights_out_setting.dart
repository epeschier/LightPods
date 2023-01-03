import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import '../../models/activity_setting.dart';
import '../../models/activity_enums.dart';
import '../multiple_choice.dart';

class LightsOutWidget extends StatefulWidget {
  final LightsOutSetting value;

  const LightsOutWidget({super.key, required this.value});

  @override
  State<LightsOutWidget> createState() => _LightsOutWidgetState();
}

class _LightsOutWidgetState extends State<LightsOutWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.value.lightsOut.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getLightsOut();
  }

  Widget _getLightsOut() => MultipleChoice(
        icon: Icons.highlight,
        text: 'Lights out',
        selectedItem: _selectedIndex,
        onItemSelected: _onMultipleChoiceChanged,
        subText: ActivityDescription.lightsOutExplanation[_selectedIndex],
        values: const ['Hit', 'Timeout', 'Both'],
        subWidget: (_selectedIndex > 0)
            ? SliderInput(
                value: widget.value.timeout,
                max: 5,
                decimals: 1,
                units: 's',
                onValueChanged: (double value) {
                  widget.value.timeout = value;
                },
              )
            : null,
      );

  void _onMultipleChoiceChanged(int index) {
    widget.value.lightsOut = LightsOutType.values[index];
    setState(() {
      _selectedIndex = index;
    });
  }
}
