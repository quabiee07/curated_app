import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileMobileView extends StatefulWidget {
  const ProfileMobileView({super.key});

  @override
  State<ProfileMobileView> createState() => _ProfileMobileViewState();
}

class _ProfileMobileViewState extends State<ProfileMobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(Routes.home),
        ),
      ),
      body: const Center(
        child: Text(
          'Profile Mobile View',
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),
    );
  }
}
