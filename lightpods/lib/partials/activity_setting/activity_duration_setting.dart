import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import 'package:lightpods/partials/multiple_choice.dart';
import '../../models/activity_enums.dart';

class ActivityDurationSetting extends StatefulWidget {
  const ActivityDurationSetting({super.key});

  @override
  State<ActivityDurationSetting> createState() =>
      _ActivityDurationSettingState();
}

class _ActivityDurationSettingState extends State<ActivityDurationSetting> {
  late Column _valueSliders;

  @override
  void initState() {
    _valueSliders = _getValueSliders();
    super.initState();
  }

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
        subWidget: _valueSliders,
        //    (_lightsOutIndex > 0) ? SliderInput(max: 5, units: 'min') : null,
      );

  Column _getValueSliders() => Column(
        children: _getSubWidget(),
      );

  List<Widget> _getSubWidget() {
    List<Widget> sliders = [];
    if (_lightsOutIndex != 1) {
      sliders.add(SliderInput(max: 100, units: 'hits'));
    }
    if (_lightsOutIndex > 0) {
      sliders.add(SliderInput(max: 5, units: 'min'));
    }
    return sliders;
  }

  int _lightsOutIndex = 0;

  void _onLightsOutExplanationToggleClick(int index) {
    setState(() {
      _lightsOutIndex = index;
      _valueSliders = _getValueSliders();
    });
  }
}
