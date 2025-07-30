import 'package:curated_app/core/domain/utils/url_launcher_service.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/core/presentation/resources/drawables.dart';
import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/snack_bar_utils.dart';
import 'package:curated_app/core/presentation/widgets/clickable.dart';
import 'package:curated_app/core/presentation/widgets/svg_image.dart';
import 'package:curated_app/features/feedback/presentation/screens/feedback_widget.dart';
import 'package:curated_app/features/home/domain/model/post.dart';
import 'package:curated_app/features/home/presentation/manager/home_provider.dart';
import 'package:curated_app/features/home/presentation/manager/home_state.dart';
import 'package:curated_app/features/post/domain/model/created_post_model.dart';
import 'package:curated_app/features/post/presentation/manager/post_provider.dart';
import 'package:curated_app/features/profile/presentation/manager/profile_provider.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HomePostDesktopView extends StatefulWidget {
  const HomePostDesktopView({super.key});

  @override
  State<HomePostDesktopView> createState() => _HomePostDesktopViewState();
}

class _HomePostDesktopViewState extends CustomState<HomePostDesktopView> {
  ScrollController controller = ScrollController();
  HomeProvider? _provider;
  PostProvider? _postProvider;
  ProfileProvider? _profileProvider;
  bool isCreatePost = false;

  Set<int> hoveredIndices = {};

  @override
  void onStarted() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        _provider?.loadMore();
      }
    });
    _provider?.getHomePagePosts();
    _profileProvider?.getUser();
    _provider?.listen((event) {
      if (event is String) {
        showError(event);
      } else if (event is CreatedPost) {
        toggleCreatePost();
        showSuccess('Post created successfully');
        _provider?.getHomePagePosts();
      }
    });
    super.onStarted();
  }

  toggleCreatePost() {
    setState(() {
      isCreatePost = !isCreatePost;
    });
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning!';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<HomeProvider, PostProvider, ProfileProvider>(
        builder: (_, provider, postProvider, profileProvider, __) {
      _provider ??= provider;
      _postProvider ??= postProvider;

      _profileProvider ??= profileProvider;
      final state = provider.state;
      final pState = profileProvider.state;
      return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          color: Colors.grey[100],
          child: Stack(
            children: [
              // The main scrollable content
              SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(
                      // Pass data down, don't let widgets look up
                      username: pState.profile?.username ?? 'User',
                    ),
                    const Gap(16),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                      height: 1,
                    ),

                    const Gap(16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Clickable(
                          onPressed: () {
                            toggleCreatePost();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: purple,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              spacing: 8,
                              children: [
                                Text(
                                  'Send Feedback',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.feedback_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(24),
                    _buildContent(
                        provider, state), // Logic is now in a function
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: isCreatePost,
                  child: FeedbackWidget(
                    onClose: toggleCreatePost,
                    onSend: () {},
                  ),
                ),
              ),
            ],
          ));
    });
  }

  // Helper function to keep the build method clean
  Widget _buildContent(HomeProvider provider, HomeState state) {
    if (provider.loading) {
      return Center(
        child: LoadingAnimationWidget.bouncingBall(
          color: purple,
          size: 150,
        ),
      );
    }

    if (state.posts.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SvgImage(asset: emptyState, height: 400),
            const Gap(16),
            Text('No posts available',
                style: TextStyle(fontSize: 18, color: Colors.grey[600])),
          ],
        ),
      );
    }
    // No more Positioned or Expanded here, just the grid
    return _PostGrid(posts: state.posts);
  }
}

// WIDGET 1: The Header
class _Header extends StatelessWidget {
  final String username;
  const _Header({required this.username});

  String get _greetingMessage {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFF6a3093), Color(0xFFa044ff)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Use a Column for vertical arrangement
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_greetingMessage, $username',
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Gap(8),
              const Text(
                'Look through the posts and find the best one for you',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// WIDGET 2: The Grid itself
class _PostGrid extends StatelessWidget {
  final List<PostModel> posts;
  const _PostGrid({required this.posts});

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 4, // Adjust for responsiveness if needed
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      itemCount: posts.length,
      shrinkWrap: true, // Important for nested scrolling
      physics: const NeverScrollableScrollPhysics(),
      // The parent Column scrolls
      itemBuilder: (context, index) {
        final post = posts[index];
        // Each card is its own widget now
        return _PostCard(post: post);
      },
    );
  }
}

class _PostCard extends StatefulWidget {
  final PostModel post;
  const _PostCard({required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _isHovered = false;
  // Instantiate the service once, not in a callback
  final UrlLauncherService _urlLauncher = UrlLauncherService();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _urlLauncher.launchUrlInNewWindow(widget.post.url),
        child: Container(
          height: 250,
          width: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: _isHovered ? Border.all(color: purple, width: 2.0) : null,
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: FastCachedImage(
                  url: cosplayUrl + widget.post.image,
                  fit: BoxFit.cover,
                  height: 120, // Give a fixed height to the image container
                  width: double.infinity,
                  errorBuilder: (context, url, error) =>
                      const Icon(Icons.image_not_supported, size: 50),
                  loadingBuilder: (p0, p1) => Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: purple, size: 50)),
                ),
              ),
              const Gap(8),
              Text(
                widget.post.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(4),
              Flexible(
                child: Text(
                  widget.post.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
