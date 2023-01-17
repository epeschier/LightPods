import 'package:flutter/material.dart';
import 'package:lightpods/components/value_widget.dart';

import '../theme/theme.dart';
import 'header_with_value.dart';

class RangedSliderInput extends ValueWidget<RangeValues> {
  final String description;
  final String? units;
  final double max;
  int decimals;
  bool showValue;
  RangeValues valueRange;

  RangedSliderInput(
      {super.key,
      this.decimals = 0,
      onValueChanged,
      required this.description,
      this.units,
      this.showValue = true,
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
      padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
      child: HeaderWithValue(
          text: widget.description,
          value: (widget.showValue) ? _getValueAsString() : null));

  String _getValueAsString() =>
      "${widget.valueRange.start.toStringAsFixed(widget.decimals)}-${widget.valueRange.end.toStringAsFixed(widget.decimals)} ${widget.units ?? ''}";

  Widget _getSlider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RangeSlider(
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
          }));
}
