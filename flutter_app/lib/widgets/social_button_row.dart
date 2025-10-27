import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SocialButtonRow extends StatelessWidget {
  const SocialButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    final socialButtons = [
      _SocialButton(icon: Icons.g_mobiledata, label: 'Google', color: const Color(0xFFDB4437)),
      _SocialButton(icon: Icons.facebook_rounded, label: 'Facebook', color: const Color(0xFF1877F2)),
      _SocialButton(icon: Icons.apple_rounded, label: 'Apple', color: const Color(0xFF000000)),
    ];

    return Column(
      children: [
        Text(
          'Or continue with',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final (index, button) in socialButtons.indexed)
              button
                  .animate()
                  .fadeIn(duration: 300.ms, delay: (index + 1) * 80.ms)
                  .moveY(begin: 10, curve: Curves.easeOut)
                  .scale(begin: const Offset(0.95, 0.95)),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: color,
        backgroundColor: color.withOpacity(0.08),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
