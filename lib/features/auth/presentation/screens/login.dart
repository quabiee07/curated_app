import 'package:curated_app/core/presentation/widgets/responsive_widget.dart';
import 'package:curated_app/features/auth/presentation/screens/views/desktop/login_desktop_view.dart';
import 'package:curated_app/features/auth/presentation/screens/views/mobile/login_mobile_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const String id = "/login";


  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: LoginMobileView(),
      desktop: LoginDesktopView(),
    );
  }
}
