import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import 'package:lightpods/partials/multiple_choice.dart';
import '../../components/toggle_options.dart';
import '../../models/activity_enums.dart';
import '../activity_setting.dart';

class ActivityDurationSetting extends StatefulWidget {
  const ActivityDurationSetting({super.key});

  @override
  State<ActivityDurationSetting> createState() =>
      _ActivityDurationSettingState();
}

class _ActivityDurationSettingState extends State<ActivityDurationSetting> {
  @override
  Widget build(BuildContext context) {
    return _getActivityDuration();
  }

  Widget _getActivityDuration() => MultipleChoice(
        icon: Icons.lightbulb,
        text: 'Activity Duration',
        onItemSelected: _onLightsOutExplanationToggleClick,
        subText:
            ActivityDescription.activityDurationExplanation[_lightsOutIndex],
        values: const ['Hits', 'Timeout', 'Both'],
        subWidget:
            (_lightsOutIndex > 0) ? SliderInput(max: 5, units: 'min') : null,
      );

  int _lightsOutIndex = 0;

  void _onLightsOutExplanationToggleClick(int index) {
    setState(() {
      _lightsOutIndex = index;
    });
  }
}
