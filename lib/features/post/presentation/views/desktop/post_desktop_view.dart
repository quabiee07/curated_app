import 'package:curated_app/core/domain/utils/url_launcher_service.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/core/presentation/resources/drawables.dart';
import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/navigation_mixin.dart';
import 'package:curated_app/core/presentation/utils/snack_bar_utils.dart';
import 'package:curated_app/core/presentation/widgets/clickable.dart';
import 'package:curated_app/core/presentation/widgets/svg_image.dart';
import 'package:curated_app/features/post/presentation/manager/post_provider.dart';
import 'package:curated_app/features/post/presentation/widgets/create_post_widget.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class PostDesktopView extends StatefulWidget {
  const PostDesktopView({super.key});

  @override
  State<PostDesktopView> createState() => _PostDesktopViewState();
}

class _PostDesktopViewState extends CustomState<PostDesktopView> {
  PostProvider? _provider;
  bool isCreatePost = false;
  Set<int> hoveredIndices = {};

  toggleCreatePost() {
    setState(() {
      isCreatePost = !isCreatePost;
    });
  }

  @override
  void onStarted() {
    _provider?.getPosts();
    _provider?.listen((event) {
      if (event is String) {
        showError(event);
        context.pop();
      }
    });
    super.onStarted();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: Consumer<PostProvider>(builder: (_, provider, __) {
        _provider ??= provider;
        final state = provider.state;
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[100],
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                SizedBox(
                  height: constraints.maxHeight,
                  child: Column(
                    children: [
                      // Header section - fixed height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Clickable(
                            onPressed: toggleCreatePost,
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
                                    'Create Post',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(24),
                      // Content section - takes remaining space
                      Expanded(
                        child: provider.loading
                            ? Center(
                                child: LoadingAnimationWidget.bouncingBall(
                                  color: purple,
                                  size: 150,
                                ),
                              )
                            : state.posts.isEmpty
                                ? Center(
                                    child: Column(
                                      spacing: 16,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SvgImage(
                                          asset: emptyState,
                                          height: 400,
                                          width: 400,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          'No posts available',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : AlignedGridView.count(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    itemCount: state.posts.length,
                                    itemBuilder: (context, index) {
                                      final post = state.posts[index];

                                      return MouseRegion(
                                        onEnter: (event) {
                                          setState(() {
                                            hoveredIndices.add(index);
                                          });
                                        },
                                        onExit: (event) {
                                          setState(() {
                                            hoveredIndices.remove(index);
                                          });
                                        },
                                        child: Clickable(
                                          onPressed: () {
                                            UrlLauncherService()
                                                .launchUrlInNewWindow(post.url);
                                          },
                                          child: Container(
                                            height: 240,
                                            width: 250,
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border:
                                                  hoveredIndices.contains(index)
                                                      ? Border.all(
                                                          color: purple,
                                                          width: 2.0,
                                                        )
                                                      : null,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: FastCachedImage(
                                                      url: cosplayUrl +
                                                          post.image,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              url, error) =>
                                                          const Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        size: 50,
                                                        color: Colors.grey,
                                                      ),
                                                      loadingBuilder: (p0, p1) {
                                                        return Center(
                                                          child: LoadingAnimationWidget
                                                              .staggeredDotsWave(
                                                            color: purple,
                                                            size: 50,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const Gap(8),
                                                Text(
                                                  post.title,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Gap(4),
                                                Flexible(
                                                  child: Text(
                                                    post.description,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600],
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );  
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: isCreatePost,
                    child: CreatePostWidget(
                      onClose: () {
                        toggleCreatePost();
                      },
                      onPostCreate: () {
                        provider.createPost();
                      },
                    ),
                  ),
                )
              ],
            );
          }),
        );
      }),
    );
  }
}
