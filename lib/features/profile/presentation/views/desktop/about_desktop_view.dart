import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AboutDesktopView extends StatelessWidget {
  const AboutDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => print('Edit Profile tapped'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.edit,
                  color: purple,
                ),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: purple,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Bio',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
            'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          const Gap(24),
          const Text(
            'Location',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () => print('Location tapped'),
            child: const Text(
              '342 Glenwood Avenue, Springfield, USA',
              style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
