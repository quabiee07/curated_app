import 'package:curated_app/core/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SecurityDesktopView extends StatelessWidget {
  const SecurityDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const Text(
            'To enhance your account security, please change your password regularly.',
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          const Gap(24),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Current Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const Gap(16),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const Gap(16),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Confirm New Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const Gap(32),
                  Button(
                      title: 'Change Password',
                      onPressed: () {
                        // Handle password change logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Password changed successfully!')),
                        );
                      }),
                ],
              )),
              Expanded(child: Container())
            ],
          )
        ],
      ),
    );
  }
}
