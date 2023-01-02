import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import 'package:lightpods/models/activity_setting.dart';
import '../../models/activity_enums.dart';
import '../multiple_choice.dart';

class LightsOutWidget extends StatefulWidget {
  final LightsOutSetting selectedItem;

  const LightsOutWidget({super.key, required this.selectedItem});

  @override
  State<LightsOutWidget> createState() => _LightsOutWidgetState();
}

class _LightsOutWidgetState extends State<LightsOutWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.selectedItem.lightsOut.index;
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
            ? SliderInput(max: 5, decimals: 1, units: 's')
            : null,
      );

  void _onMultipleChoiceChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
