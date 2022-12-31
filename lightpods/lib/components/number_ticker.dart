import 'package:flutter/material.dart';
import 'package:lightpods/components/value_widget.dart';
import 'package:lightpods/theme/theme.dart';

class NumberTicker extends ValueWidget<int> {
  //StatefulWidget {
  final int? minValue;
  final int? maxValue;

  const NumberTicker({super.key, onValueChanged, this.maxValue, this.minValue})
      : super(onValueChanged);

  @override
  State createState() => _NumberTicker();
}

class _NumberTicker extends State<NumberTicker> {
  int _value = 1;

  void _updateValue(int value) {
    setState(() {
      _value = value;
    });
    widget.notifyValueChange(value);
  }

  @override
  void initState() {
    _value = widget.minValue ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      RoundButton(
          icon: const Icon(Icons.add),
          enabled: _value < (widget.maxValue ?? 1000),
          click: () {
            _updateValue(_value + 1);
          }),
      Text(
        _value.toString(),
        style: const TextStyle(
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
      RoundButton(
          icon: const Icon(Icons.remove),
          enabled: _value > (widget.minValue ?? 1),
          click: () {
            _updateValue(_value - 1);
          }),
    ]);
  }
}

class RoundButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? click;
  final bool? enabled;
  const RoundButton({super.key, required this.icon, this.click, this.enabled});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled == true ? click : null,
      style: toggleButtonStyle.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            } else if (states.contains(MaterialState.disabled)) {
              return ThemeColors.buttonDisabledIconColor;
            }
            return ThemeColors.buttonColor; // Use the component's default.
          },
        ),
      ),
      child: icon,
    );
  }
}
