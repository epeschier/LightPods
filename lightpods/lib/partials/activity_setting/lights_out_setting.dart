import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import '../../components/toggle_options.dart';
import '../../models/activity_enums.dart';
import '../activity_setting.dart';
import '../multiple_choice.dart';

class LightsOutSetting extends StatefulWidget {
  const LightsOutSetting({super.key});

  @override
  State<LightsOutSetting> createState() => _LightsOutSettingState();
}

class _LightsOutSettingState extends State<LightsOutSetting> {
  @override
  Widget build(BuildContext context) {
    return _getLightsOut();
  }

  Widget _getLightsOut() => MultipleChoice(
        icon: Icons.alarm,
        text: 'Lights out',
        onItemSelected: _onActivityDurationToggleClick,
        subText: ActivityDescription.lightsOutExplanation[_lightsOutIndex],
        values: const ['Hits', 'Timeout', 'Both'],
        subWidget: (_lightsOutIndex > 0)
            ? SliderInput(max: 5, decimals: 1, units: 'sec')
            : null,
      );

  int _lightsOutIndex = 0;

  void _onActivityDurationToggleClick(int index) {
    setState(() {
      _lightsOutIndex = index;
    });
  }
}
