import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import 'package:lightpods/helper.dart';
import 'package:lightpods/pages/edit_workout/multiple_choice.dart';
import '../../../models/activity_enums.dart';
import '../../../models/duration_setting.dart';

class ActivityDurationSetting extends StatefulWidget {
  final DurationSetting value;

  const ActivityDurationSetting({super.key, required this.value});

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
        icon: Icons.schedule,
        text: 'Activity Duration',
        selectedItem: widget.value.durationType.index,
        onItemSelected: _onLightsOutExplanationToggleClick,
        subText: ActivityDescription
            .activityDurationExplanation[widget.value.durationType.index],
        values: const ['Hits', 'Timeout', 'Both'],
        subWidget: _getValueSliders(),
      );

  void _onLightsOutExplanationToggleClick(int index) {
    setState(() {
      widget.value.durationType = ActivityDurationType.values[index];
    });
    widget.value.durationType = ActivityDurationType.values[index];
  }

  Column _getValueSliders() => Column(
        children: [
          Visibility(
            visible: widget.value.durationType != ActivityDurationType.timeout,
            child: SliderInput(
                description: 'Hits',
                units: 'hits',
                onValueChanged: _onNumberOfHitsChanged,
                value: widget.value.numberOfHits,
                max: 100),
          ),
          Visibility(
            visible: widget.value.durationType.index > 0,
            child: SliderInput(
                description: 'Timeout',
                stringFunction: _getTimeValue,
                onValueChanged: _onTimeoutChanged,
                value: widget.value.timeout,
                max: 120),
          ),
        ],
      );

  void _onNumberOfHitsChanged(double value) {
    setState(() {
      widget.value.numberOfHits = value;
    });
  }

  void _onTimeoutChanged(double value) {
    setState(() {
      widget.value.timeout = Helper.roundDouble(value, 0);
    });
  }

  String _getTimeValue(double value) => Helper.getTimeMmSs(value);
}
