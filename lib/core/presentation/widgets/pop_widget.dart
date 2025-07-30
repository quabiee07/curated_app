import 'package:flutter/material.dart';
import 'package:curated_app/core/presentation/utils/navigation_mixin.dart';
import 'package:curated_app/core/presentation/widgets/clickable.dart';
import 'package:curated_app/core/presentation/widgets/svg_image.dart';

class PopWidget extends StatelessWidget {
  const PopWidget({super.key, this.callback});

  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Clickable(
        onPressed: callback == null
            ? () {
                context.pop();
              }
            : callback!,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgImage(
            asset: '',
            color: theme.colorScheme.onSurface,
          ),
        ));
  }
}
