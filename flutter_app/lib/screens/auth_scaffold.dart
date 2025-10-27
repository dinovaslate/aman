import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/animated_background.dart';
import '../widgets/auth_header.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthScaffold extends StatefulWidget {
  const AuthScaffold({super.key});

  @override
  State<AuthScaffold> createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          const AnimatedBackground(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 900;
                final cardWidth = math.min(constraints.maxWidth * (isWide ? 0.4 : 0.9), 460.0);

                final tabBar = Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: colorScheme.primary.withOpacity(0.15),
                    ),
                    labelColor: colorScheme.primary,
                    unselectedLabelColor: colorScheme.onSurfaceVariant,
                    tabs: const [
                      Tab(text: 'Login'),
                      Tab(text: 'Register'),
                    ],
                  ),
                );

                final card = SizedBox(
                  width: cardWidth,
                  child: Card(
                    elevation: 10,
                    shadowColor: colorScheme.primary.withOpacity(0.2),
                    color: Colors.white.withOpacity(0.85),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AuthHeader(tabController: _tabController),
                          const SizedBox(height: 24),
                          tabBar,
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 420,
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                                LoginScreen(),
                                RegisterScreen(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fade(duration: 400.ms).scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack),
                );

                return Align(
                  alignment: isWide ? Alignment.centerRight : Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? constraints.maxWidth * 0.1 : 16,
                      vertical: isWide ? 48 : 24,
                    ),
                    child: card,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
