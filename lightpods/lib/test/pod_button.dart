import 'package:flutter/material.dart';
import 'package:lightpods/test/fake_pod.dart';

class PodButton extends StatefulWidget {
  final FakePod pod;

  const PodButton({super.key, required this.pod});
  @override
  State<PodButton> createState() => _PodButtonState();
}

class _PodButtonState extends State<PodButton> {
  String get id => widget.pod.id;

  late Color _color = Colors.grey;

  @override
  void initState() {
    widget.pod.onColorUpdated = (Color newColor) {
      setState(() {
        _color = newColor;
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.pod.initiateClickCallback();
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(50),
        backgroundColor: _color,
      ),
      child: null,
    );
  }
}
