import 'package:curated_app/core/presentation/theme/colors/colors.dart';
import 'package:curated_app/core/presentation/widgets/clickable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class BottomNavBarItem {
  BottomNavBarItem({
    this.icon,
    required this.text,
  });

  IconData? icon;
  String text;

  static List<BottomNavBarItem> get items => [
        BottomNavBarItem(
          text: "Home",
          icon: Icons.dashboard_outlined,
        ),
        BottomNavBarItem(
          text: "Posts",
          icon: Icons.article_outlined,
        ),
        BottomNavBarItem(
          text: "Profile",
          icon: Icons.person_outline,
        ),
        BottomNavBarItem(
          text: 'Settings',
          icon: Icons.settings_outlined,
        ),
      ];

  static List<BottomNavBarItem> get selectedItems => [
        BottomNavBarItem(
          text: "Home",
          icon: Icons.dashboard,
        ),
        BottomNavBarItem(
          text: "Posts",
          icon: Icons.article,
        ),
        BottomNavBarItem(
          text: "Profile",
          icon: Icons.person,
        ),
        BottomNavBarItem(
          text: 'Settings',
          icon: Icons.settings,
        ),
      ];
}

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.currentIndex,
    this.items,
    this.selectedItems,
    this.height = 70.0,
    this.iconSize = 24.0,
    this.onTabSelected,
  }) {
    assert(items?.length == 2 || items?.length == 4);
  }

  final List<BottomNavBarItem>? items;
  final List<BottomNavBarItem>? selectedItems;
  final double? height;
  final double? iconSize;
  final ValueChanged<int>? onTabSelected;
  final int selectedIndex;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _BottomNavBarState(selectedIndex: selectedIndex);
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  var selectedIndex = 0;

  _BottomNavBarState({required this.selectedIndex});

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  _updateIndex(int index) {
    widget.onTabSelected!(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> items = List.generate(
      widget.currentIndex == widget.selectedIndex
          ? widget.items!.length
          : widget.selectedItems!.length,
      (int index) {
        return _buildTabItem(
          item: widget.currentIndex == index
              ? widget.selectedItems![index]
              : widget.items![index],
          index: index,
          onPressed: _updateIndex,
          theme: theme,
        );
      },
    );

    return BottomAppBar(
      color: theme.colorScheme.surface,
      height: widget.height,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildTabItem({
    required BottomNavBarItem item,
    required ThemeData theme,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    return Clickable(
      onPressed: () {
        HapticFeedback.lightImpact();
        onPressed(index);
      },
      child: AnimatedContainer(
        height: widget.height,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1.0,
            end: 1.5,
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeIn,
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  item.icon!,
                  size: widget.iconSize,
                  color: widget.currentIndex == index
                      ? purple
                      : theme.iconTheme.color,
                ),
                const Gap(6),
                Text(
                  item.text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 10,
                    color: widget.currentIndex == index
                        ? purple
                        : theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
