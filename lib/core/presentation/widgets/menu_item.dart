import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: selected ? purple.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: selected ? purple : Colors.purple[600],
            ),
            Text(
              label,
              style: selected
                  ? theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      color: purple,
                      fontWeight: FontWeight.bold,
                    )
                  : theme.textTheme.titleSmall?.copyWith(
                      fontSize: 16,
                      color: Colors.purple[600],
                      fontWeight: FontWeight.normal,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileMenuItem extends StatelessWidget {
  const MobileMenuItem({
    super.key,
    required this.label,
    this.isHovered = false,
    required this.index,
    required this.height,
    required this.onTap,
  });

  final String label;
  final bool isHovered;
  final int index;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    TextStyle? menuLabelStyle = _getResponsiveTextStyle(
      context,
      Theme.of(context).textTheme.bodyLarge,
      Theme.of(context).textTheme.titleMedium,
      Theme.of(context).textTheme.titleSmall,
    );

    TextStyle? hoverMenuLabelStyle = _getResponsiveTextStyle(
      context,
      Theme.of(context).textTheme.titleSmall,
      Theme.of(context).textTheme.headlineSmall,
      Theme.of(context).textTheme.titleMedium,
    );

    double stickWidth = _getResponsiveWidth(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              width: isHovered ? stickWidth : 0,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Gap(10), // horizontalSpaceMedium
            Opacity(
              opacity: isHovered ? 1.0 : 0.5,
              child: AnimatedDefaultTextStyle(
                style: isHovered
                    ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        )
                    : Theme.of(context).textTheme.bodySmall!,
                duration: Duration(milliseconds: 100),
                child: Text(
                  _formatIndex(index + 1),
                ),
              ),
            ),
            Gap(10), // horizontalSpaceMedium
            Opacity(
              opacity: isHovered ? 1.0 : 0.5,
              child: AnimatedDefaultTextStyle(
                style: isHovered ? hoverMenuLabelStyle! : menuLabelStyle!,
                duration: Duration(milliseconds: 100),
                child: Text(
                  label,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatIndex(int number) {
    return number < 10 ? '0$number' : '$number';
  }

  TextStyle? _getResponsiveTextStyle(
    BuildContext context,
    TextStyle? mobile,
    TextStyle? desktop,
    TextStyle? tablet,
  ) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return mobile;
    } else if (width < 1200) {
      return tablet;
    }
    return desktop;
  }

  double _getResponsiveWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 50;
    } else if (width < 1200) {
      return 70;
    }
    return 100;
  }
}
