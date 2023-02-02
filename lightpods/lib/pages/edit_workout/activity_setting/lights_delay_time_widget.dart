import 'package:flutter/material.dart';
import '../../../models/activity_setting.dart';
import '../../../components/ranged_slider_input.dart';
import '../../../components/slider_input.dart';
import '../../../models/activity_enums.dart';
import '../../../models/light_delay_time_setting.dart';
import '../multiple_choice.dart';

class LightDelayTimeWidget extends StatefulWidget {
  LightDelayTimeSetting value;

  LightDelayTimeWidget({super.key, required this.value});

  @override
  State<LightDelayTimeWidget> createState() => _LightDelayTimeWidgetState();
}

class _LightDelayTimeWidgetState extends State<LightDelayTimeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getLightsOut();
  }

  Widget _getLightsOut() => MultipleChoice(
        icon: Icons.hourglass_empty,
        text: 'Light Delay Time',
        //valueDescription: widget.value.toString(),
        selectedItem: widget.value.delayTimeType.index,
        onItemSelected: _onLightsDelayToggleClick,
        subText: ActivityDescription
            .lightDelayTimeExplanation[widget.value.delayTimeType.index],
        values: const ['None', 'Fixed', 'Random'],
        subWidget: _getSubwidget(),
      );

  void _onLightsDelayToggleClick(int index) {
    setState(() {
      widget.value.delayTimeType = LightDelayTimeType.values[index];
    });
  }

  Widget? _getSubwidget() {
    if (widget.value.delayTimeType == LightDelayTimeType.random) {
      return RangedSliderInput(
        description: 'Timeout',
        valueRange:
            RangeValues(widget.value.randomTimeMin, widget.value.randomTimeMax),
        max: 5,
        decimals: 1,
        onValueChanged: (RangeValues value) {
          setState(() {
            widget.value.randomTimeMin = value.start;
            widget.value.randomTimeMax = value.end;
          });
        },
      );
    }
    if (widget.value.delayTimeType == LightDelayTimeType.fixed) {
      return SliderInput(
        description: 'Timeout',
        value: widget.value.fixedTime,
        units: 's',
        max: 5,
        decimals: 1,
        onValueChanged: (double value) {
          setState(() {
            widget.value.fixedTime = value;
          });
        },
      );
    }
    return null;
  }
}
