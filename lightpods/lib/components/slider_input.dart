import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SliderInput extends StatefulWidget {
  final String? units;
  final double max;
  int? decimals;
  SliderInput({super.key, this.decimals, this.units, required this.max});

  @override
  State createState() => _SliderInput();
}

class _SliderInput extends State<SliderInput> {
  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Expanded(
            child: Slider(
              value: _currentSliderValue,
              max: widget.max,
              divisions: _getDivisions(),
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 80,
            child: Text(
              textAlign: TextAlign.right,
              _getValueString(),
              style: ThemeColors.valueText,
            ),
          ),
        ],
      )
    ]);
  }

  String _getValueString() =>
      '${_currentSliderValue.toStringAsFixed(widget.decimals ?? 0)} ${widget.units ?? ''}'
          .trimRight();

  int _getDivisions() =>
      widget.max.toInt() *
      (widget.decimals != null ? widget.decimals! * 10 : 1);
}
