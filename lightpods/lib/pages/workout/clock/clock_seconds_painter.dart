import 'dart:math';

import 'package:flutter/material.dart';

class ClockSecondsPainter extends CustomPainter {
  final Color? accentColor;
  final double angle;

  ClockSecondsPainter({required this.angle, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);

    var secSize = pi / 10; // Size of the bar
    var timeAngle = angle - (pi / 2) - (secSize / 2);

    var radiusOuter = size.height * .9;

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = center.dy * .01
      ..strokeCap = StrokeCap.round
      ..color = accentColor!.withAlpha(40);

    var outerRect = Rect.fromCenter(
      center: center,
      width: radiusOuter,
      height: radiusOuter,
    );

    // Track.
    canvas.drawArc(outerRect, 0, pi * 2, false, paint);

    paint
      ..strokeWidth = center.dy * .03
      ..color = accentColor!;

    // Indicator.
    canvas.drawArc(outerRect, timeAngle, secSize, false, paint);
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
