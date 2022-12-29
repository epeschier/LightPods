import 'package:flutter/material.dart';

import '../theme/theme.dart';

class RangedSliderInput extends StatefulWidget {
  final String units;
  final double max;
  int? decimals;
  RangedSliderInput(
      {super.key, this.decimals, required this.units, required this.max});

  @override
  State createState() => _RangedSliderInput();
}

class _RangedSliderInput extends State<RangedSliderInput> {
  RangeValues _currentRangeValues = const RangeValues(1, 2);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Expanded(
              child: RangeSlider(
                  values: _currentRangeValues,
                  max: widget.max,
                  divisions: _getDivisions(),
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  })),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 120,
            child: Text(
              textAlign: TextAlign.right,
              '${_currentRangeValues.start.toStringAsFixed(widget.decimals ?? 0)} - ${_currentRangeValues.end.toStringAsFixed(widget.decimals ?? 0)} ${widget.units}',
              style: ThemeColors.valueText,
            ),
          ),
        ],
      )
    ]);
  }

  int _getDivisions() =>
      widget.max.toInt() *
      (widget.decimals != null ? widget.decimals! * 10 : 1);
}
