import 'package:flutter/material.dart';
import 'player_color_setting.dart';
import '../../../components/slider_input.dart';
import '../../../models/distracting_colors.dart';
import '../../../models/pod_colors.dart';

class DistactingColorChance extends StatefulWidget {
  final DistractingColors value;

  const DistactingColorChance({super.key, required this.value});

  @override
  State<DistactingColorChance> createState() => _DistactingColorChanceState();
}

class _DistactingColorChanceState extends State<DistactingColorChance> {
  bool _showChanceSlider = false;

  @override
  void initState() {
    _showChanceSlider = widget.value.size() > 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getNumberOfDistractingColors();
  }

  Widget _getNumberOfDistractingColors() => Column(children: [
        PlayerColorSetting(
            icon: Icons.alt_route,
            colors: PodColorService.distractingColors,
            subText: 'Hitting these colors will result in a penalty',
            text: 'Distracting colors',
            selectedColorIndex: widget.value.selectedColorIndex,
            onValueChanged: _updateValue),
        Visibility(visible: _showChanceSlider, child: _getAppearance()),
      ]);

  void _updateValue(List<int> value) {
    setState(() {
      _showChanceSlider = value.isNotEmpty;
      widget.value.selectedColorIndex = value;
    });
  }

  Widget _getAppearance() {
    return SliderInput(
      description: 'Chance to appear',
      value: widget.value.chanceToAppear.toDouble(),
      max: 100,
      units: '%',
      showValue: true,
      onValueChanged: (double value) {
        setState(() {
          widget.value.chanceToAppear = value.toInt();
        });
      },
    );
  }
}
