import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import 'package:lightpods/partials/multiple_choice.dart';
import '../../models/activity_enums.dart';
import '../../models/duration_setting.dart';

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
        valueDescription: _getValueText(),
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
                onValueChanged: _onNumberOfHitsChanged,
                value: widget.value.numberOfHits,
                max: 100),
          ),
          Visibility(
            visible: widget.value.durationType.index > 0,
            child: SliderInput(
                description: 'Timeout',
                onValueChanged: _onTimeoutChanged,
                value: widget.value.timeout,
                max: 10),
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
      widget.value.timeout = value;
    });
  }

  String _getValueText() {
    String description = '';
    if (widget.value.durationType != ActivityDurationType.timeout) {
      description += '${widget.value.numberOfHits.toInt()} hits';
    }

    if (widget.value.durationType == ActivityDurationType.hitsAndTimeout) {
      description += ' / ';
    }

    if (widget.value.durationType != ActivityDurationType.numberOfHits) {
      description += '${widget.value.timeout.toStringAsFixed(1)} min';
    }

    return description;
  }
}
