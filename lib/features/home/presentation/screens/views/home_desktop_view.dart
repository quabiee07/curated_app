import 'package:curated_app/core/presentation/widgets/side_menu.dart';
import 'package:curated_app/features/home/presentation/screens/views/home_post_desktop_view.dart';
import 'package:curated_app/features/post/presentation/views/desktop/post_desktop_view.dart';
import 'package:curated_app/features/profile/presentation/views/desktop/profile_desktop_view.dart';
import 'package:flutter/material.dart';

class HomeDesktopView extends StatefulWidget {
  const HomeDesktopView({super.key});

  @override
  State<HomeDesktopView> createState() => _HomeDesktopViewState();
}

class _HomeDesktopViewState extends State<HomeDesktopView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomePostDesktopView(),
    PostDesktopView(),
    // Center(
    //   child: Text(
    //     'Leaderboard Screen',
    //     style: TextStyle(fontSize: 24, color: Colors.black87),
    //   ),
    // ),
    ProfileDesktopView(),
    //  Center(
    //   child: Text(
    //     'Settings Screen',
    //     style: TextStyle(fontSize: 24, color: Colors.black87),
    //   ),
    // ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          SideMenuWidget(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) => _onItemTapped(index),
          ),
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
