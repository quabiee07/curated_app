import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/routes.dart';
import 'package:curated_app/core/presentation/utils/utils.dart';
import 'package:curated_app/features/auth/application/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:sprung/sprung.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends CustomState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void onStart() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duration of the scaling animation
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Logger().d("Splash animation completed");
        final authService = getIt<AuthService>();
        switch (authService.authState) {
          // case AuthState.:
          //   context.go(Routes.register);
          //   break;
          case AuthState.unauthenticated:
            context.go(Routes.login);
            break;
          case AuthState.authenticated:
            context.go(Routes.home);
            break;
          case AuthState.unknown:
            // Should not happen, but as a fallback
            context.go(Routes.register);
            break;
        }
      }
    });

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Sprung.overDamped, // A good curve for a dramatic scale
      ),
    );

    _textAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Start at the bottom
      end: const Offset(0.0, 0.0), // End at the center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Sprung.underDamped,
      ),
    );

    // Start the animation after a short delay
    Future.delayed(const Duration(milliseconds: 800), () {
      _controller.forward();
    });

    super.onStart();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxDimension = screenWidth(context) > screenHeight(context)
        ? screenWidth(context)
        : screenHeight(context);
    // Calculate a scale factor that ensures the circle covers the screen
    // The initial circle size is 50.0 (radius 25.0).
    // We need to scale it by (maxDimension / (initial_circle_radius * 2))
    // A bit extra to ensure full coverage
    final scaleFactor =
        (maxDimension / 50.0) * 1.5; // Multiply by 1.5 for safe over-coverage

    return Scaffold(
      backgroundColor:
          Colors.white, // Background color before the circle covers it
      body: Center(
        child: Stack(
          // Use Stack to layer the circle and the text
          alignment: Alignment.center, // Center children in the stack
          children: [
            // The scaling circle
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value *
                      scaleFactor, // Apply the calculated scale
                  child: Container(
                    width: 50.0, // Initial width of the circle
                    height: 50.0, // Initial height of the circle
                    decoration: const BoxDecoration(
                      color: Color(0xFF8A2BE2), // Purple color
                      shape: BoxShape.circle, // Make it a circle
                    ),
                  ),
                );
              },
            ),
            // The fading text
            SlideTransition(
              position: _textAnimation,
              child: Text(
                'Curated', // The text to display
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: Colors.white, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
