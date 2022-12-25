import 'package:flutter/material.dart';

class ToggleOptions extends StatefulWidget {
  final List<String> values;
  final Function onClick;

  const ToggleOptions({Key? key, required this.values, required this.onClick})
      : super(key: key);

  @override
  State createState() => _ToggleOptions();
}

class _ToggleOptions extends State<ToggleOptions> {
  final List<bool> _selectedItems = [];
  final List<Widget> _text = [];

  @override
  void initState() {
    for (var element in widget.values) {
      _text.add(Text(element));
      _selectedItems.add(false);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      //constraints: BoxConstraints(minWidth: 100),
      onPressed: (int index) {
        setState(() {
          // The button that is tapped is set to true, and the others to false.
          for (int i = 0; i < _selectedItems.length; i++) {
            _selectedItems[i] = i == index;
          }
        });
        widget.onClick(index);
      },
      isSelected: _selectedItems,
      children: _text,
    );
  }
}
