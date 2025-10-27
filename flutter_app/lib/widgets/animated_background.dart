import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 14))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = Curves.easeInOut.transform(_controller.value);
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary.withOpacity(0.9 - progress * 0.2),
                colorScheme.secondary.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CustomPaint(
            painter: _BlobPainter(progress: progress, color: colorScheme.onPrimary.withOpacity(0.07)),
            child: const SizedBox.expand(),
          ),
        );
      },
    ).animate().fadeIn(duration: 600.ms);
  }
}

class _BlobPainter extends CustomPainter {
  const _BlobPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    final width = size.width;
    final height = size.height;

    final noise = math.sin(progress * math.pi * 2) * 40;

    path.moveTo(0, height * 0.3 + noise);
    path.cubicTo(width * 0.2, height * 0.2 - noise, width * 0.4, height * 0.4 + noise, width * 0.6, height * 0.3);
    path.cubicTo(width * 0.8, height * 0.2 - noise, width, height * 0.5, width, height * 0.7);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    canvas.drawPath(path, paint);

    final circlePaint = Paint()..color = color.withOpacity(0.5);
    final circleOffset = Offset(width * 0.2 + noise, height * 0.2);
    canvas.drawCircle(circleOffset, 120 + noise, circlePaint);
  }

  @override
  bool shouldRepaint(covariant _BlobPainter oldDelegate) => oldDelegate.progress != progress;
}
