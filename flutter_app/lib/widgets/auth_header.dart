import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
        ).animate().fadeIn(duration: 300.ms).moveY(begin: 10, curve: Curves.easeOut),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: tabController,
          builder: (context, _) {
            final isLogin = tabController.index == 0;
            return Text(
              isLogin
                  ? 'Use your credentials or social account to sign in.'
                  : 'Create an account to sync your experience across devices.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            );
          },
        ).animate().fadeIn(duration: 400.ms, delay: 100.ms).moveY(begin: 12, curve: Curves.easeOut),
      ],
    );
  }
}
