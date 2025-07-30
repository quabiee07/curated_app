import 'package:curated_app/core/presentation/widgets/responsive_widget.dart';
import 'package:curated_app/features/profile/presentation/views/desktop/profile_desktop_view.dart';
import 'package:curated_app/features/profile/presentation/views/mobile/profile_mobile_view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const String id = "/profile";


  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: ProfileMobileView(),
      desktop: ProfileDesktopView(),
    );
  }
}
