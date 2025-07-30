import 'package:curated_app/core/presentation/widgets/responsive_widget.dart';
import 'package:curated_app/features/post/presentation/views/desktop/post_desktop_view.dart';
import 'package:curated_app/features/post/presentation/views/mobile/post_mobile_view.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});
  static const String id = "/post";


  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: PostMobileView(),
      desktop: PostDesktopView(),
    );
  }
}
