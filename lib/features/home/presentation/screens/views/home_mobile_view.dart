import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/routes.dart';
import 'package:curated_app/core/presentation/utils/utils.dart';
import 'package:curated_app/core/presentation/widgets/menu_button.dart';
import 'package:curated_app/features/home/domain/model/post.dart';
import 'package:curated_app/features/home/presentation/manager/home_provider.dart';
import 'package:curated_app/features/home/presentation/screens/menu.dart';
import 'package:curated_app/features/home/presentation/widget/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({super.key});

  @override
  State<HomeMobileView> createState() => _HomeMobileViewState();
}

class _HomeMobileViewState extends State<HomeMobileView>
    with SingleTickerProviderStateMixin {
  bool _isDrawerOpen = false;
  late final _menuController;
  HomeProvider? _provider;
  final kMenuRoutes = [
    Routes.home,
    Routes.post,
    Routes.profile,
  ];
  PostModel post = PostModel(
    id: '0',
    title: 'New substack post',
    user: PostUser(id: '10', name: 'John Doe', profileImage: ''),
    url: cosplayUrl,
    userId: '',
    image: '',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  final posts = [
    PostModel(
      id: '0',
      title: 'New substack post',
      user: PostUser(id: '10', name: 'John Doe', profileImage: ''),
      url: cosplayUrl,
      userId: '',
      image: '',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    PostModel(
      id: '0',
      title: 'New substack post',
      user: PostUser(id: '10', name: 'John Doe', profileImage: ''),
      url: cosplayUrl,
      userId: '',
      image: '',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    PostModel(
      id: '0',
      title: 'New substack post',
      user: PostUser(id: '10', name: 'John Doe', profileImage: ''),
      url: cosplayUrl,
      userId: '',
      image: '',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    PostModel(
      id: '0',
      title: 'New substack post',
      user: PostUser(id: '10', name: 'John Doe', profileImage: ''),
      url: cosplayUrl,
      userId: '',
      image: '',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    PostModel(
      id: '0',
      title: 'New substack post',
      user: PostUser(id: '10', name: 'John Doe', profileImage: ''),
      url: cosplayUrl,
      userId: '',
      image: '',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    PostModel(
      id: '0',
      title: 'New substack post',
      user: PostUser(id: '10', name: 'John Doe', profileImage: ''),
      url: cosplayUrl,
      userId: '',
      image: '',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void onMenuTapped() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
    if (_isDrawerOpen) {
      _menuController.forward();
    } else {
      _menuController.reverse();
    }
  }

  void _handleNavigation(String routeName) {
    _menuController.reverse().then((value) {
      if (_menuController.status == AnimationStatus.dismissed) {
        context.go(routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (_, provider, __) {
      _provider ??= provider;
      // final state = provider.state;

      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(backgroundColor: purple, elevation: 0, actions: [
            MenuButton(
              onPressed: onMenuTapped,
              hasMenuTapped: _isDrawerOpen,
            ),
            const Gap(20)
          ]),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth(context),
                      height: 120,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6a3093), Color(0xFFa044ff)],
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hello, User',
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Gap(8),
                          const Text(
                            'Look through the posts and find the best one for you',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const Gap(24),
                    AlignedGridView.count(
                      crossAxisCount: 2, // Adjust for responsiveness if needed
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemCount: posts.length,
                      shrinkWrap: true, // Important for nested scrolling
                      physics: const NeverScrollableScrollPhysics(),
                      // The parent Column scrolls
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        // Each card is its own widget now
                        return PostCard(post: post);
                      },
                    )

                    // Column(
                    //   spacing: 16,
                    //   children: List.generate(posts.length, (index)=> PostCard(post: posts.elementAt(index))),
                    // )
                  ],
                ),
              ),
              MenuPage(
                onMenuItemTapped: (index) =>
                    _handleNavigation(kMenuRoutes[index]),
                animation: _menuController.view,
              ),
            ],
          )
          );
    });
  }
}
