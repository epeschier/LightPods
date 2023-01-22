import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lightpods/theme/theme.dart';

import 'clock_seconds_painter.dart';

class RotatingSecond extends StatefulWidget {
  final double size;
  late bool forward;
  RotatingSecond({super.key, required this.size, this.forward = true});

  @override
  State<RotatingSecond> createState() => RotatingSecondState();
}

class RotatingSecondState extends State<RotatingSecond>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  void start() => _controller.repeat();
  void stop() => _controller.stop();
  void reset() => _controller.value = 0;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = _getTween().animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
  }

  Tween<double> _getTween() => widget.forward
      ? Tween(begin: 0.0, end: 2 * pi)
      : Tween(begin: 2 * pi, end: 0.0);

  @override
  Widget build(BuildContext context) {
    var size = widget.size;
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return Center(
            child: SizedBox(
              height: size,
              width: size,
              child: CustomPaint(
                size: Size(size, size),
                painter: ClockSecondsPainter(
                    accentColor: ThemeColors.primaryColor,
                    angle: _animation.value),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
