import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Top
    _drawDashedLine(
      canvas,
      Offset(0, 0),
      Offset(size.width, 0),
      paint,
    );

    // Right
    _drawDashedLine(
      canvas,
      Offset(size.width, 0),
      Offset(size.width, size.height),
      paint,
    );

    // Bottom
    _drawDashedLine(
      canvas,
      Offset(size.width, size.height),
      Offset(0, size.height),
      paint,
    );

    // Left
    _drawDashedLine(
      canvas,
      Offset(0, size.height),
      Offset(0, 0),
      paint,
    );
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    double totalLength = (end - start).distance;
    final direction = (end - start).direction;
    double drawnLength = 0.0;

    while (drawnLength < totalLength) {
      final currentStart = start + Offset.fromDirection(direction, drawnLength);
      final dashEndLength = (drawnLength + dashWidth).clamp(0, totalLength).toDouble();
      final currentEnd = start + Offset.fromDirection(direction, dashEndLength);

      canvas.drawLine(currentStart, currentEnd, paint);
      drawnLength += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
