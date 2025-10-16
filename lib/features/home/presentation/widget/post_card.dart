import 'package:curated_app/core/domain/utils/url_launcher_service.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/features/home/domain/model/post.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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
