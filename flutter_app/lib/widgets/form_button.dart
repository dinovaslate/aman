import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FormButton extends StatefulWidget {
  const FormButton({super.key, required this.label, required this.onPressed, required this.icon});

  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  State<FormButton> createState() => _FormButtonState();
}

class _FormButtonState extends State<FormButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = 1.0 + (_controller.value * 0.02);
            return Transform.scale(scale: scale, child: child);
          },
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: colorScheme.onPrimary),
                  const SizedBox(width: 12),
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(
                    duration: const Duration(milliseconds: 1700),
                    colors: [
                      colorScheme.onPrimary.withOpacity(0.7),
                      colorScheme.onPrimary,
                      colorScheme.onPrimary.withOpacity(0.7),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
