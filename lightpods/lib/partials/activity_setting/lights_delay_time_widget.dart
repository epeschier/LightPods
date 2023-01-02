import 'package:flutter/material.dart';
import 'package:lightpods/models/activity_setting.dart';
import '../../components/ranged_slider_input.dart';
import '../../components/slider_input.dart';
import '../../models/activity_enums.dart';
import '../multiple_choice.dart';

class LightDelayTimeWidget extends StatefulWidget {
  final LightDelayTimeSetting setting;

  const LightDelayTimeWidget({super.key, required this.setting});

  @override
  State<LightDelayTimeWidget> createState() => _LightDelayTimeWidgetState();
}

class _LightDelayTimeWidgetState extends State<LightDelayTimeWidget> {
  int _lightDelayIndex = 0;

  @override
  void initState() {
    _lightDelayIndex = widget.setting.delayTimeType.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getLightsOut();
  }

  Widget _getLightsOut() => MultipleChoice(
        icon: Icons.hourglass_empty,
        text: 'Light Delay Time',
        selectedItem: _lightDelayIndex,
        onItemSelected: _onLightsDelayToggleClick,
        subText:
            ActivityDescription.lightDelayTimeExplanation[_lightDelayIndex],
        values: const ['None', 'Fixed', 'Random'],
        subWidget: _getSubwidget(),
      );

  void _onLightsDelayToggleClick(int index) {
    setState(() {
      _lightDelayIndex = index;
    });
  }

  Widget? _getSubwidget() {
    if (_lightDelayIndex == LightDelayTimeType.random.index) {
      return RangedSliderInput(max: 5, decimals: 1, units: 's');
    }
    if (_lightDelayIndex == LightDelayTimeType.fixed.index) {
      return SliderInput(max: 5, decimals: 1, units: 's');
    }
    return null;
  }
}
