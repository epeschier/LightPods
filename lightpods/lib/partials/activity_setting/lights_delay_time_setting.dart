import 'package:flutter/material.dart';
import 'package:lightpods/components/ranged_slider_input.dart';
import '../../components/slider_input.dart';
import '../../components/toggle_options.dart';
import '../../models/activity_enums.dart';
import '../activity_setting.dart';

class LightDelayTimeSetting extends StatefulWidget {
  const LightDelayTimeSetting({super.key});

  @override
  State<LightDelayTimeSetting> createState() => _LightDelayTimeSettingState();
}

class _LightDelayTimeSettingState extends State<LightDelayTimeSetting> {
  @override
  Widget build(BuildContext context) {
    return _getLightsOut();
  }

  Widget _getLightsOut() => ActivitySetting(
        icon: Icons.light_mode,
        text: 'Light Delay Time',
        subText:
            ActivityDescription.lightDelayTimeExplanation[_lightDelayIndex],
        widget: ToggleOptions(
          values: const ['None', 'Fixed', 'Random'],
          selectedItem: 0,
          onClick: _onLightsDelayToggleClick,
        ),
        subWidget: _getSubwidget(),
      );

  int _lightDelayIndex = 0;
  void _onLightsDelayToggleClick(int index) {
    setState(() {
      _lightDelayIndex = index;
    });
  }

  Widget? _getSubwidget() {
    if (_lightDelayIndex == LightDelayTimeType.none.index) {
      return null;
    }
    if (_lightDelayIndex == LightDelayTimeType.random.index) {
      return RangedSliderInput(max: 5, decimals: 1, units: 'sec');
    }
    if (_lightDelayIndex == LightDelayTimeType.fixed.index) {
      return SliderInput(max: 5, decimals: 1, units: 'sec');
    }
  }
}
