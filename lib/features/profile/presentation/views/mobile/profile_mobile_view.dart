import 'package:flutter/material.dart';

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
        title: const Text('Profile Mobile View'),
      ),
      body: Center(
        child: Text(
          'This is the mobile view of the profile screen.',
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),
    );
  }
}
