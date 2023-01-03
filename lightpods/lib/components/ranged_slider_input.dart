import 'package:flutter/material.dart';
import 'package:lightpods/components/value_widget.dart';

import '../theme/theme.dart';

class RangedSliderInput extends ValueWidget<RangeValues> {
  final String units;
  final double max;
  int? decimals;
  RangeValues valueRange;

  RangedSliderInput(
      {super.key,
      this.decimals,
      onValueChanged,
      required this.units,
      required this.max,
      required this.valueRange})
      : super(onValueChanged);

  @override
  State createState() => _RangedSliderInput();
}

class _RangedSliderInput extends State<RangedSliderInput> {
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
                  values: widget.valueRange,
                  max: widget.max,
                  divisions: _getDivisions(),
                  labels: RangeLabels(
                    widget.valueRange.start.round().toString(),
                    widget.valueRange.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      widget.valueRange = values;
                      widget.onValueChanged?.call(values);
                    });
                  })),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 100,
            child: Text(
              textAlign: TextAlign.right,
              '${widget.valueRange.start.toStringAsFixed(widget.decimals ?? 0)}-${widget.valueRange.end.toStringAsFixed(widget.decimals ?? 0)} ${widget.units}',
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
