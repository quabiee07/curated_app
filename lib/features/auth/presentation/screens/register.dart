import 'package:curated_app/core/presentation/widgets/responsive_widget.dart';
import 'package:curated_app/features/auth/presentation/screens/views/desktop/register_desktop_view.dart';
import 'package:curated_app/features/auth/presentation/screens/views/mobile/register_mobile_view.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const String id = "/register";


  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: RegisterMobileView(),
      desktop: RegisterDesktopView(),
    );
  }
}
