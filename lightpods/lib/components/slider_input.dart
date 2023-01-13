import 'package:flutter/material.dart';
import '../components/value_widget.dart';
import 'header_with_value.dart';

class SliderInput extends ValueWidget<double> {
  final String? description;
  final String? units;
  final double max;
  int? decimals;
  final double? value;
  bool? showValue = false;

  SliderInput(
      {super.key,
      onValueChanged,
      this.decimals,
      this.units,
      this.description,
      required this.max,
      this.showValue,
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 6,
      ),
      Visibility(
        visible: (widget.description != null),
        child: _getSliderHeader(),
      ),
      _getSlider(),
    ]);
  }

  Widget _getSliderHeader() => Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
      child: HeaderWithValue(
          text: widget.description!,
          value: (widget.showValue ?? false)
              ? _currentSliderValue.toStringAsFixed(widget.decimals ?? 0)
              : null));

  Widget _getSlider() => Slider(
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
      );

  int _getDivisions() {
    if ((widget.decimals ?? 0) >= 0) {
      return widget.max.toInt();
    }
    return widget.max.toInt() * widget.decimals! * 10;
  }
}
