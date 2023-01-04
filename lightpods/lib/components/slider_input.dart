import 'package:flutter/material.dart';
import '../components/value_widget.dart';
import '../theme/theme.dart';

class SliderInput extends ValueWidget<double> {
  final String description;
  final String? units;
  final double max;
  int? decimals;
  final double? value;

  SliderInput(
      {super.key,
      onValueChanged,
      this.decimals,
      this.units,
      required this.description,
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

  int _getDivisions() =>
      widget.max.toInt() *
      (widget.decimals != null ? widget.decimals! * 10 : 1);
}
