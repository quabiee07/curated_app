import 'package:curated_app/core/presentation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shell widget that provides persistent navigation UI (sidebar for desktop)
/// For mobile, we don't use a shell - routes are rendered directly
class AppShell extends StatelessWidget {
  final Widget child;
  final StatefulNavigationShell navigationShell;

  const AppShell({
    super.key,
    required this.child,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we're on mobile width
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    if (isMobile) {
      // On mobile, just render the child without shell
      return child;
    }

    // On desktop, use the shell with sidebar
    return _DesktopShell(
      navigationShell: navigationShell,
      child: child,
    );
  }
}

/// Desktop shell with side menu
class _DesktopShell extends StatelessWidget {
  final Widget child;
  final StatefulNavigationShell navigationShell;

  const _DesktopShell({
    required this.child,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          SideMenuWidget(
            selectedIndex: navigationShell.currentIndex,
            onItemTapped: (index) => _onItemTapped(index, context),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
