import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import 'package:lightpods/partials/multiple_choice.dart';
import '../../models/activity_enums.dart';
import '../../models/activity_setting.dart';

class ActivityDurationSetting extends StatefulWidget {
  final DurationSetting durationSetting;

  const ActivityDurationSetting({super.key, required this.durationSetting});

  @override
  State<ActivityDurationSetting> createState() =>
      _ActivityDurationSettingState();
}

class _ActivityDurationSettingState extends State<ActivityDurationSetting> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.durationSetting.durationType.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getActivityDuration();
  }

  Widget _getActivityDuration() => MultipleChoice(
        icon: Icons.schedule,
        text: 'Activity Duration',
        selectedItem: _selectedIndex,
        onItemSelected: _onLightsOutExplanationToggleClick,
        subText:
            ActivityDescription.activityDurationExplanation[_selectedIndex],
        values: const ['Hits', 'Timeout', 'Both'],
        subWidget: _getValueSliders(),
      );

  void _onLightsOutExplanationToggleClick(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Column _getValueSliders() => Column(
        children: [
          Visibility(
            visible: _selectedIndex != 1,
            child: SliderInput(
                onValueChanged: (value) {
                  //widget.durationHits = value;
                  // TODO change value
                },
                value: widget.durationSetting.numberOfHits,
                max: 100,
                units: 'hits'),
          ),
          Visibility(
            visible: _selectedIndex > 0,
            child: SliderInput(
                value: widget.durationSetting.timeout, max: 10, units: 'min'),
          ),
        ],
      );
}
