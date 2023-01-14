import 'package:flutter/material.dart';
import 'package:lightpods/components/value_widget.dart';

import '../theme/theme.dart';

class RangedSliderInput extends ValueWidget<RangeValues> {
  final String description;
  final String? units;
  final double max;
  int? decimals;
  RangeValues valueRange;

  RangedSliderInput(
      {super.key,
      this.decimals,
      onValueChanged,
      required this.description,
      this.units,
      required this.max,
      required this.valueRange})
      : super(onValueChanged);

  @override
  State createState() => _RangedSliderInput();
}

class _RangedSliderInput extends State<RangedSliderInput> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 6,
      ),
      _getSliderHeader(),
      _getSlider(),
    ]);
  }

  Widget _getSliderHeader() => Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        widget.description,
        style: ThemeColors.sliderHeaderText,
      ));

  Widget _getSlider() => RangeSlider(
      values: widget.valueRange,
      max: widget.max,
      labels: RangeLabels(
        widget.valueRange.start.round().toString(),
        widget.valueRange.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          widget.valueRange = values;
          widget.onValueChanged?.call(values);
        });
      });
}
