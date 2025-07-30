import 'package:curated_app/core/presentation/resources/drawables.dart';
import 'package:curated_app/core/presentation/utils/custom_state.dart';
import 'package:curated_app/core/presentation/utils/utils.dart';
import 'package:curated_app/core/presentation/widgets/button.dart';
import 'package:curated_app/core/presentation/widgets/clickable.dart';
import 'package:curated_app/core/presentation/widgets/input_field.dart';
import 'package:curated_app/core/presentation/widgets/slide_animation_wrapper.dart';
import 'package:curated_app/features/feedback/presentation/manager/feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({
    super.key,
    required this.onClose,
    required this.onSend,
  });
  final VoidCallback onClose;
  final VoidCallback onSend;

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends CustomState<FeedbackWidget>
    with TickerProviderStateMixin {
  late GifController _controller;
  final images = [happy, neutral, sad];
  final text = ["Happy", "Meh", "Sad"];

  @override
  void onStart() {
    _controller = GifController(vsync: this);
    super.onStart();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => FeedbackProvider(),
      child: Consumer<FeedbackProvider>(
        builder: (_, provider, __) {
          // _provider ??= provider;
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
                            'Send Feedback',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.onClose();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const Gap(8),
                      const Text(
                        'We value your feedback. Please share your thoughts or suggestions below.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                      const Gap(24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 24,
                        children: List.generate(images.length, (index) {
                          return MouseRegion(
                            onEnter: (event) {
                              setState(() {
                                // hoveredIndices.add(index);
                              });
                            },
                            onExit: (event) {
                              setState(() {});
                            },
                            child: Clickable(
                              onPressed: () {},
                              child: Container(
                                height: 170,
                                width: 150,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: .09),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        // color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Gif(
                                          image: NetworkImage(
                                            images[index],
                                          ),
                                          controller:
                                              _controller, // if duration and fps is null, original gif fps will be used.
                                          //fps: 30,
                                          //duration: const Duration(seconds: 3),
                                          autostart: Autostart.once,
                                          placeholder: (context) => const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          onFetchCompleted: () {
                                            _controller.reset();
                                            _controller.forward();
                                          },
                                        ),
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      text[index],
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Gap(4),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const Gap(16),
                      InputField(
                        hint: '',
                        maxLines: 15,
                        value: state.message,
                        error: state.messageError,
                        maxLength: 255,
                        onChange: (String value) {
                          provider.setMessage(value);
                        },
                      ),
                      const Gap(24),
                      Button(
                          title: 'Submit Feedback',
                          isLoading: provider.loading,
                          onPressed: () {
                            widget.onSend();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
