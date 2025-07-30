import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/widgets/menu_item.dart';
import 'package:curated_app/features/auth/presentation/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SideMenuWidget extends StatefulWidget {
  SideMenuWidget(
      {super.key, required this.selectedIndex, required this.onItemTapped});
  int selectedIndex;
  final Function(int) onItemTapped;

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(builder: (_, provider, __) {
        return Container(
          width: 250,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 14.0),
                child: Row(
                  spacing: 10,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.curtains_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Curated',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(24),
              MenuItem(
                icon: Icons.home_outlined,
                label: 'Home',
                selected: widget.selectedIndex == 0,
                onTap: () => widget.onItemTapped(0),
              ),
              const Gap(8),
              MenuItem(
                icon: Icons.article_outlined,
                label: 'Posts',
                selected: widget.selectedIndex == 1,
                onTap: () => widget.onItemTapped(1),
              ),
              const Gap(8),
              // MenuItem(
              //   icon: Icons.leaderboard_outlined,
              //   label: 'Leaderboard',
              //   selected: widget.selectedIndex == 2,
              //   onTap: () => widget.onItemTapped(2),
              // ),
              // const Gap(8),
              MenuItem(
                icon: Icons.person_outline,
                label: 'Profile',
                selected: widget.selectedIndex == 2,
                onTap: () => widget.onItemTapped(2),
              ),
              const Gap(8),
              // MenuItem(
              //   icon: Icons.settings_outlined,
              //   label: 'Settings',
              //   selected: widget.selectedIndex == 4,
              //   onTap: () => widget.onItemTapped(4),
              // ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    _showLogoutConfirmationDialog(context, provider);
                  },
                  child: const Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.logout, color: Colors.purple),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
        );
      }),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context, AuthProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                provider.logout();
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
