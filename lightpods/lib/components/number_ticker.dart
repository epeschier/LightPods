import 'package:flutter/material.dart';
import 'value_widget.dart';
import 'round_button.dart';

class NumberTicker extends ValueWidget<int> {
  //StatefulWidget {
  final int? minValue;
  final int? maxValue;
  final int value;

  const NumberTicker(
      {super.key,
      onValueChanged,
      required this.value,
      this.maxValue,
      this.minValue})
      : super(onValueChanged);

  @override
  State createState() => _NumberTicker();
}

class _NumberTicker extends State<NumberTicker> {
  late int _value;

  void _updateValue(int value) {
    setState(() {
      _value = value;
    });
    widget.notifyValueChange(value);
  }

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      RoundButton(
          icon: const Icon(Icons.remove),
          enabled: _value > (widget.minValue ?? 1),
          click: () {
            _updateValue(_value - 1);
          }),
      Text(
        _value.toString(),
        style: const TextStyle(
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
      RoundButton(
          icon: const Icon(Icons.add),
          enabled: _value < (widget.maxValue ?? 1000),
          click: () {
            _updateValue(_value + 1);
          }),
    ]);
  }
}
