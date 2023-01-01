import 'package:flutter/material.dart';

class PodButton extends StatefulWidget {
  final Function onClick;
  final Color color;
  final String id;

  const PodButton(
      {required this.id,
      required this.onClick,
      required this.color,
      super.key});

  @override
  State<PodButton> createState() => _PodButtonState();
}

class _PodButtonState extends State<PodButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onClick(widget.id);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(50),
        backgroundColor: widget.color,
      ),
      child: null,
    );
  }
}
