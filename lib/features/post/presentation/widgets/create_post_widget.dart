import 'dart:io';
import 'dart:convert';

import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/snack_bar_utils.dart';
import 'package:curated_app/core/presentation/utils/utils.dart';
import 'package:curated_app/core/presentation/widgets/button.dart';
import 'package:curated_app/core/presentation/widgets/clickable.dart';
import 'package:curated_app/core/presentation/widgets/dashed_container.dart';
import 'package:curated_app/core/presentation/widgets/input_field.dart';
import 'package:curated_app/core/presentation/widgets/slide_animation_wrapper.dart';
import 'package:curated_app/features/post/domain/model/created_post_model.dart';
import 'package:curated_app/features/post/presentation/manager/post_provider.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget(
      {super.key, required this.onClose, required this.onPostCreate});

  final VoidCallback onClose;
  final VoidCallback onPostCreate;

  @override
  State<CreatePostWidget> createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends CustomState<CreatePostWidget> {
  PostProvider? _provider;
  final picker = ImagePicker();
  String? _imageDataUrl;

  @override
  void onStarted() {
    _provider?.listen((event) {
      if (event is String) {
        showError(event);
      } else if (event is CreatedPost) {
        widget.onClose();
        showSuccess('Post created successfully');
        _provider?.getPosts();
      }
    });
    super.onStarted();
  }

  Future getImage(ImageSource source) async {
    var image = await picker.pickImage(source: source);
    setState(() {
      if (image != null) {
        if (kIsWeb) {
          // For web, convert XFile directly to data URL
          image.readAsBytes().then((bytes) {
            final base64String = base64Encode(bytes);
            final dataUrl = 'data:image/jpeg;base64,$base64String';
            setState(() {
              _imageDataUrl = dataUrl;

              // Add the image to the provider's state
              final file = XFile.fromData(
                bytes,
                name: image.name,
                mimeType: image.mimeType,
                path: image.path,
              );
              _provider?.state.images.add(file);
            });
          }).catchError((e) {
            print('Error reading image bytes: $e');
          });
        } else {
          // For mobile platforms
          // final file = File(image.path);
          // _provider?.state.images.add(file);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<PostProvider>(
      builder: (_, provider, __) {
        _provider ??= provider;
        final state = provider.state;
        return SlideAnimationWrapper(
          index: 0,
          child: IntrinsicHeight(
            child: Container(
              width: screenWidth(context) * 0.4,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: .5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Create Post',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: widget.onClose,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const Gap(16),
                    const Text(
                      'Substack Post URL:',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Gap(8),
                    InputField(
                      hint: 'Enter Substack Post URL',
                      value: state.url,
                      error: state.urlError,
                      onChange: (String value) {
                        provider.setUrl(value);
                      },
                    ),
                    const Gap(16),
                    const Text(
                      'Post Title:',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Gap(8),
                    InputField(
                      hint: 'Enter Post Title',
                      value: state.title,
                      error: state.titleError,
                      onChange: (String value) {
                        provider.setTitle(value);
                      },
                    ),
                    const Gap(16),
                    const Text(
                      'Post Description:',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Gap(8),
                    InputField(
                      hint: 'Enter Post Description',
                      maxLines: 5,
                      value: state.description,
                      error: state.descriptionError,
                      maxLength: 255,
                      onChange: (String value) {
                        provider.setDescription(value);
                      },
                    ),
                    const Gap(16),
                    const Text(
                      'Post Image:',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Gap(8),
                    Clickable(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: _imageDialog(context),
                              );
                            });
                      },
                      child: DashedContainer(
                          child: (state.images.isNotEmpty) ||
                                  (kIsWeb && _imageDataUrl != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: kIsWeb && _imageDataUrl != null
                                      ? FastCachedImage(
                                          url: _imageDataUrl!,
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (p0, p1) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(
                                                color: purple,
                                              ),
                                            );
                                          },
                                        )
                                      : state.images.isNotEmpty
                                          ? Image.file(
                                              File(state.images[0].path),
                                              height: 150,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : Text(
                                              'Image selected: ${state.images[0].path}',
                                              maxLines: 1,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color:
                                                      Colors.grey.shade600),
                                            ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      const Icon(Icons.add_a_photo, size: 32),
                                      const Gap(8),
                                      Text(
                                        'Click to add images',
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          fontSize: 12,
                                          color: purple,
                                        ),
                                      ),
                                      const Gap(8),
                                      Text(
                                        '1600x1200(4:3) recommended, up to 10MB each',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ])),
                    ),
                   
                    const Gap(24),
                    Button(
                      title: 'Create Post',
                      isLoading: state.isPosting,
                      onPressed: widget.onPostCreate,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _imageDialog(context) {
    final theme = Theme.of(context);
    return Container(
      height: 115,
      width: 250,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.image,
                    color: purple,
                  ),
                  const Gap(16),
                  Text(
                    'Gallery',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const Gap(5),
            const Divider(),
            const Gap(5),
            InkWell(
              onTap: () {
                getImage(ImageSource.camera);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.camera_alt_rounded,
                    color: purple,
                  ),
                  const Gap(16),
                  Text(
                    'Camera',
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
