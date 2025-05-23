import 'package:flutter/material.dart';
class DottedProgressBar extends StatelessWidget {
  final double progress;
  final int totalDots;
  final double dotSize;
  final double spacing;

  const DottedProgressBar({
    super.key,
    required this.progress,
    required this.totalDots,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dotSize,
      child: Center(
        child: CustomPaint(
          painter: _DottedProgressPainter(
            progress: progress,
            totalDots: totalDots,
            dotSize: dotSize,
            spacing: spacing,
          ),
        ),
      ),
    );
  }
}

class _DottedProgressPainter extends CustomPainter {
  final double progress;
  final int totalDots;
  final double dotSize;
  final double spacing;

  _DottedProgressPainter({
    required this.progress,
    required this.totalDots,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintBg = Paint()..color = Colors.grey.shade300;
    final paintProgress = Paint()..color = Colors.blueAccent;

    for (int i = 0; i < totalDots; i++) {
      double x = i * (dotSize + spacing);
      Paint paint = (i / totalDots) < progress ? paintProgress : paintBg;
      canvas.drawCircle(Offset(x, size.height / 2), dotSize / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
