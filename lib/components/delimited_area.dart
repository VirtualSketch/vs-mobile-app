import 'package:flutter/material.dart';

const double _kRadius = 10;
const double _kBorderWidth = 3;

class DelimitedArea extends CustomPainter {
  DelimitedArea();

  @override
  void paint(Canvas canvas, Size size) {
    final rrectBorder = RRect.fromRectAndRadius(
        Offset.zero & size, const Radius.circular(_kRadius));
    final rrectShadow = RRect.fromRectAndRadius(
        const Offset(0, 3) & size, const Radius.circular(_kRadius));

    final borderPaint = Paint()
      ..strokeWidth = _kBorderWidth
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrectBorder, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
