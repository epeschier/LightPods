import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import '../../components/toggle_options.dart';
import '../../models/activity_enums.dart';
import '../activity_setting.dart';

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

  Widget _getLightsOut() => ActivitySetting(
        icon: Icons.alarm,
        text: 'Lights out',
        subText: ActivityDescription.lightsOutExplanation[_lightsOutIndex],
        widget: ToggleOptions(
          values: const ['Hits', 'Timeout', 'Both'],
          selectedItem: 0,
          onClick: _onActivityDurationToggleClick,
        ),
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
