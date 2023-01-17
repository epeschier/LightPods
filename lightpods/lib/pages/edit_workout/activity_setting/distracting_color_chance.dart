import 'package:flutter/material.dart';

import '../../../components/number_ticker.dart';
import '../../../components/slider_input.dart';
import '../../../models/distracting_colors.dart';
import 'activity_setting_container.dart';

class DistactingColorChance extends StatefulWidget {
  final DistractingColors value;

  const DistactingColorChance({super.key, required this.value});

  @override
  State<DistactingColorChance> createState() => _DistactingColorChanceState();
}

class _DistactingColorChanceState extends State<DistactingColorChance> {
  @override
  Widget build(BuildContext context) {
    return _getNumberOfDistractingColors();
  }

  Widget _getNumberOfDistractingColors() => ActivitySettingContainer(
        icon: Icons.alt_route,
        text: 'Distracting Colors',
        subText: 'Hitting these colors will result in a penalty',
        widget: NumberTicker(
          value: widget.value.numberOfDistractingColors,
          minValue: 0,
          maxValue: 4,
          onValueChanged: (int value) {
            setState(() {
              widget.value.numberOfDistractingColors = value;
            });
          },
        ),
        subWidget: Visibility(
            visible: widget.value.numberOfDistractingColors > 0,
            child: _getSubwidget()),
      );

  Widget _getSubwidget() {
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
    ;
  }
}
