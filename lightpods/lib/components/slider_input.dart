import 'package:flutter/material.dart';
import '../components/value_widget.dart';
import '../theme/theme.dart';

class SliderInput extends ValueWidget<double> {
  final String? units;
  final double max;
  int? decimals;
  final double? value;

  SliderInput(
      {super.key,
      onValueChanged,
      this.decimals,
      this.units,
      required this.max,
      this.value})
      : super(onValueChanged);

  @override
  State createState() => _SliderInput();
}

class _SliderInput extends State<SliderInput> {
  double _currentSliderValue = 1;

  @override
  void initState() {
    _currentSliderValue = widget.value ?? 1;
    super.initState();
  }

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
                widget.onValueChanged?.call(value);
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
