import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostMobileView extends StatefulWidget {
  const PostMobileView({super.key});

  @override
  State<PostMobileView> createState() => _PostMobileViewState();
}

class _PostMobileViewState extends State<PostMobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: const Text('Posts', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(Routes.home),
        ),
      ),
      body: Center(
        child: Text(
          'Posts Mobile View',
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),
    );
  }
}
