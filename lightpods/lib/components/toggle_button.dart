import 'package:flutter/material.dart';
import '../theme/theme.dart';

class ToggleButton extends StatefulWidget {
  final bool state;
  final IconData icon;
  final Function onClick;

  const ToggleButton({
    Key? key,
    required this.icon,
    required this.state,
    required this.onClick,
  }) : super(key: key);

  @override
  State createState() => _ToggleButton();
}

class _ToggleButton extends State<ToggleButton> {
  static Color selectedBackgroundColor = Colors.blueGrey[200]!;
  static Color unSelectedBackgroundColor = Colors.blueGrey[900]!;
  static Color selectedColor = Colors.blueGrey[600]!;
  static Color unSelectedColor = Colors.blueGrey[200]!;

  bool _state = false;
  void _toggleState() {
    setState(() {
      _state = !_state;
      widget.onClick(_state);
    });
  }

  Color getBackgroundColor() =>
      (_state) ? selectedBackgroundColor : unSelectedBackgroundColor;
  Color getIconColor() => (_state) ? selectedColor : unSelectedColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleState,
      style: toggleButtonStyle.copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(getBackgroundColor()),
      ),
      child: Icon(
        widget.icon,
        color: getIconColor(),
      ),
    );
  }
}
