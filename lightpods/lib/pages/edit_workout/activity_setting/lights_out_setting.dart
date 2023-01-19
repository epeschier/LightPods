import 'package:flutter/material.dart';
import 'package:lightpods/components/slider_input.dart';
import '../../../models/activity_enums.dart';
import '../../../models/lights_out_setting.dart';
import '../multiple_choice.dart';

class LightsOutWidget extends StatefulWidget {
  final Function? onChanged;
  final LightsOutSetting value;

  const LightsOutWidget({super.key, required this.value, this.onChanged});

  @override
  State<LightsOutWidget> createState() => _LightsOutWidgetState();
}

class _LightsOutWidgetState extends State<LightsOutWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.value.lightsOut.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getLightsOut();
  }

  Widget _getLightsOut() => MultipleChoice(
        icon: Icons.highlight,
        text: 'Lights out',
        valueDescription: widget.value.toString(),
        selectedItem: _selectedIndex,
        onItemSelected: _onMultipleChoiceChanged,
        subText: ActivityDescription.lightsOutExplanation[_selectedIndex],
        values: const ['Hit', 'Timeout', 'Both'],
        subWidget: (_selectedIndex > 0)
            ? SliderInput(
                description: 'Lights out',
                value: widget.value.timeout,
                units: 's',
                max: 5,
                decimals: 1,
                onValueChanged: (double value) {
                  setState(() {
                    widget.value.timeout = value;
                  });
                },
              )
            : null,
      );

  void _onMultipleChoiceChanged(int index) {
    widget.value.lightsOut = LightsOutType.values[index];
    setState(() {
      _selectedIndex = index;
    });
    widget.onChanged?.call();
  }
}
