import 'package:flutter/material.dart';

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
        title: const Text('Home Mobile View'),
      ),
      body: Center(
        child: Text(
          'This is the mobile view of the home screen.',
          style: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),
    );
  }
}
