import 'dart:ui';

import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    paint.color = Color(0xff282828);
    path = Path();
    path.lineTo(size.width, size.height * 0.72);
    path.cubicTo(size.width, size.height * 0.72, size.width * 0.98,
        size.height * 0.7, size.width * 0.98, size.height * 0.7);
    path.cubicTo(size.width * 0.95, size.height * 0.67, size.width * 0.9,
        size.height * 0.62, size.width * 0.86, size.height * 0.62);
    path.cubicTo(size.width * 0.81, size.height * 0.62, size.width * 0.76,
        size.height * 0.68, size.width * 0.71, size.height * 0.76);
    path.cubicTo(size.width * 0.67, size.height * 0.85, size.width * 0.62,
        size.height * 0.95, size.width * 0.57, size.height);
    path.cubicTo(size.width * 0.52, size.height * 1.02, size.width * 0.48,
        size.height * 0.98, size.width * 0.43, size.height * 0.91);
    path.cubicTo(size.width * 0.38, size.height * 0.83, size.width / 3,
        size.height * 0.72, size.width * 0.29, size.height * 0.7);
    path.cubicTo(size.width * 0.24, size.height * 0.68, size.width * 0.19,
        size.height * 0.74, size.width * 0.14, size.height * 0.73);
    path.cubicTo(size.width * 0.1, size.height * 0.71, size.width * 0.05,
        size.height * 0.61, size.width * 0.02, size.height * 0.56);
    path.cubicTo(size.width * 0.02, size.height * 0.56, 0, size.height * 0.52,
        0, size.height * 0.52);
    path.cubicTo(0, size.height * 0.52, 0, 0, 0, 0);
    path.cubicTo(0, 0, size.width * 0.02, 0, size.width * 0.02, 0);
    path.cubicTo(
        size.width * 0.05, 0, size.width * 0.1, 0, size.width * 0.14, 0);
    path.cubicTo(
        size.width * 0.19, 0, size.width * 0.24, 0, size.width * 0.29, 0);
    path.cubicTo(size.width / 3, 0, size.width * 0.38, 0, size.width * 0.43, 0);
    path.cubicTo(
        size.width * 0.48, 0, size.width * 0.52, 0, size.width * 0.57, 0);
    path.cubicTo(
        size.width * 0.62, 0, size.width * 0.67, 0, size.width * 0.71, 0);
    path.cubicTo(
        size.width * 0.76, 0, size.width * 0.81, 0, size.width * 0.86, 0);
    path.cubicTo(
        size.width * 0.9, 0, size.width * 0.95, 0, size.width * 0.98, 0);
    path.cubicTo(size.width * 0.98, 0, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width, size.height * 0.72, size.width,
        size.height * 0.72);
    path.cubicTo(size.width, size.height * 0.72, size.width, size.height * 0.72,
        size.width, size.height * 0.72);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
