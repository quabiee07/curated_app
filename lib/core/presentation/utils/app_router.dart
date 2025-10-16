import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/presentation/utils/routes.dart';
import 'package:curated_app/core/presentation/widgets/app_shell.dart';
import 'package:curated_app/core/presentation/widgets/responsive_widget.dart';
import 'package:curated_app/features/auth/application/auth_service.dart';
import 'package:curated_app/features/home/presentation/screens/views/home_mobile_view.dart';
import 'package:curated_app/features/home/presentation/screens/views/home_post_desktop_view.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/features/auth/presentation/screens/login.dart';
import 'package:curated_app/features/auth/presentation/screens/register.dart';
import 'package:curated_app/features/onboarding/presentation/screens/onboarding.dart';
import 'package:curated_app/features/post/presentation/post.dart';
import 'package:curated_app/features/profile/presentation/profile.dart';

class AppRouter {
  static final authService = getIt<AuthService>();

  GoRouter router = GoRouter(
    navigatorKey: navigator,
    initialLocation: Routes.splash,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: authService,
    redirect: (context, state) {
      final authState = authService.authState;
      final location = state.matchedLocation;

      // Always allow splash screen to show when auth state is unknown
      if (authState == AuthState.unknown) {
        return location == Routes.splash ? null : Routes.splash;
      }

      final isLoggedIn = authState == AuthState.authenticated;
      final isAuthRoute =
          location == Routes.login || location == Routes.register;
      final isSplashRoute = location == Routes.splash;

      // Allow splash screen to control its own navigation timing
      if (isSplashRoute) {
        return null;
      }

      // If user is on an auth route (login/register)
      if (isAuthRoute) {
        // If they are logged in, redirect them to home
        return isLoggedIn ? Routes.home : null;
      }

      // If user is on any protected route and NOT logged in, redirect to login
      if (!isLoggedIn) {
        return Routes.login;
      }

      // No redirect needed
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (_, __) => const RegisterPage(),
      ),
      // Shell route that maintains persistent navigation UI
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(
            navigationShell: navigationShell,
            child: navigationShell,
          );
        },
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const ResponsiveWidget(
                  mobile: HomeMobileView(),
                  desktop: HomePostDesktopView(),
                ),
              ),
            ],
          ),
          // Branch 1: Posts
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.post,
                builder: (context, state) => const PostPage(),
              ),
            ],
          ),
          // Branch 2: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const LoginPage(),
  );
}
