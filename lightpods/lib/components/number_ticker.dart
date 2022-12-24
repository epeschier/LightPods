import 'package:flutter/material.dart';

class NumberTicker extends StatefulWidget {
  final int? maxValue;
  const NumberTicker({Key? key, this.maxValue}) : super(key: key);

  @override
  State createState() => _NumberTicker();
}

class _NumberTicker extends State<NumberTicker> {
  int _value = 1;

  void _updateValue(int value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SquareButton(
            icon: const Icon(Icons.add),
            enabled: _value < (widget.maxValue ?? 1000),
            click: () {
              _updateValue(_value + 1);
            }),
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          _value.toString(),
          style: const TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
            fontSize: 20,
          ),
        ),
      ]),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SquareButton(
            icon: const Icon(Icons.remove),
            enabled: _value > 1,
            click: () {
              _updateValue(_value - 1);
            }),
      ])
    ]);
  }
}

class SquareButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? click;
  final bool? enabled;
  const SquareButton({super.key, required this.icon, this.click, this.enabled});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Ink(
          decoration: const ShapeDecoration(
            color: Color.fromARGB(255, 3, 95, 138),
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: icon,
            color: Colors.white,
            onPressed: enabled == true ? click : null,
          ),
        ),
      ),
    );
  }
}
