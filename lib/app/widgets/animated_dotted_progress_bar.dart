import 'package:flutter/material.dart';
import 'dart:async';

import 'dotted_progress_bar.dart';

class AnimatedDottedProgressBar extends StatefulWidget {
  final int totalDots;
  final double dotSize;
  final double spacing;
  final Duration speed;

  const AnimatedDottedProgressBar({
    super.key,
    this.totalDots = 20,
    this.dotSize = 10,
    this.spacing = 6,
    this.speed = const Duration(milliseconds: 100),
  });

  @override
  State<AnimatedDottedProgressBar> createState() =>
      _AnimatedDottedProgressBarState();
}

class _AnimatedDottedProgressBarState extends State<AnimatedDottedProgressBar> {
  double progress = 0.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startAnimationLoop();
  }

  void _startAnimationLoop() {
    timer = Timer.periodic(widget.speed, (timer) {
      setState(() {
        progress += 1 / widget.totalDots;
        if (progress >= 1.0) {
          progress = 0.0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DottedProgressBar(
      progress: progress,
      totalDots: widget.totalDots,
      dotSize: widget.dotSize,
      spacing: widget.spacing,
    );
  }
}
