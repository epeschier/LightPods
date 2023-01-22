import 'package:flutter/material.dart';
import 'package:lightpods/helper.dart';
import '../components/value_widget.dart';
import 'header_with_value.dart';

class SliderInput extends ValueWidget<double> {
  final String? description;
  final String? units;
  final double max;
  int decimals;
  final double? value;
  bool showValue;
  Function? stringFunction;

  SliderInput(
      {super.key,
      onValueChanged,
      this.decimals = 0,
      this.units,
      this.description,
      required this.max,
      this.showValue = true,
      this.stringFunction,
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
      const SizedBox(
        height: 6,
      ),
    ]);
  }

  Widget _getSliderHeader() => Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8, right: 12),
      child: HeaderWithValue(
          text: widget.description ?? '',
          value:
              (widget.showValue) ? _getValueText(_currentSliderValue) : null));

  Widget _getSlider() => Slider(
        value: _currentSliderValue,
        max: widget.max,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = Helper.roundDouble(value, widget.decimals);
            print(_currentSliderValue);
          });
          widget.onValueChanged?.call(value);
        },
      );

  String _getValueText(double value) => widget.stringFunction != null
      ? widget.stringFunction?.call(value)
      : "${value.toStringAsFixed(widget.decimals)} ${widget.units ?? ''}";
}
