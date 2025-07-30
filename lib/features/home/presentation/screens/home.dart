import 'package:curated_app/core/presentation/widgets/responsive_widget.dart';
import 'package:curated_app/features/home/presentation/screens/views/home_desktop_view.dart';
import 'package:curated_app/features/home/presentation/screens/views/home_mobile_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String id = "/home";


  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: HomeMobileView(),
      desktop: HomeDesktopView(),
    );
  }
}
