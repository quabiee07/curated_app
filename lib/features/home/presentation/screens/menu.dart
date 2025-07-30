import 'package:curated_app/core/presentation/utils/utils.dart';
import 'package:curated_app/core/presentation/widgets/menu_item.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  MenuPage({
    super.key,
    required this.onMenuItemTapped,
    required this.animation,
  }) : _slideDownAnimation = Tween<Offset>(
          begin: const Offset(0.0, -1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuad,
          ),
        );
  final Function(int) onMenuItemTapped;
  final Animation<double> animation;
  final Animation<Offset> _slideDownAnimation;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  late AnimationController _boxController;
  late AnimationController _colorBoxController;
  static const List<String> kMenu = [
    'Home',
    'Posts',
    'Profile',
  ];

  List<bool> _menuItemHover = List.filled(kMenu.length, false);
  final List<double> _menuItemListPositionY = List.filled(kMenu.length, 0.0);

  late EdgeInsets _padding;
  late double _menuItemHeight;
  // final List<Image> _vanGoghImages = List.generate(
  //   kaMenu.length,
  //   (index) => Image.asset(kaMenu[index]),
  // );
  int currentHoverIndex = -2;

  void _addSizeConfig() {
    _padding = EdgeInsets.symmetric(
      horizontal: getResponsiveHorizontalPadding(context),
      vertical: getResponsiveVerticalPadding(context),
    );
    double top = _padding.top;
    double bottom = _padding.bottom;
    double menuHeight = MediaQuery.of(context).size.height - (top + bottom);
    _menuItemHeight = menuHeight / kMenu.length;
    for (int i = 0; i < kMenu.length; i++) {
      _menuItemListPositionY[i] = top + (_menuItemHeight * i);
    }
  }

  // void _precacheImages() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     for (Image vanGoghImage in _vanGoghImages) {
  //       precacheImage(vanGoghImage.image, context);
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _boxController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    )..addStatusListener(boxControllerListener);
    _colorBoxController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void boxControllerListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _colorBoxController.forward();
    } else if (status == AnimationStatus.dismissed) {
      _colorBoxController.reverse();
    }
  }

  @override
  void dispose() {
    _boxController.dispose();
    _colorBoxController.dispose();
    super.dispose();
  }

  void onHover(PointerHoverEvent event) {
    double y = event.position.dy;
    int index = _menuItemListPositionY.lastIndexWhere((itemY) => y >= itemY);
    if (index != -1) {
      currentHoverIndex = index;
      startSlideContainerAnimation();
      _menuItemHover = List.filled(kMenu.length, false);
      _menuItemHover[index] = true;
      setState(() {});
    }
  }

  void onExit(PointerExitEvent event) {
    _menuItemHover = List.filled(kMenu.length, false);
    dismissSlideContainerAnimation();
    setState(() {});
  }

  void startSlideContainerAnimation() {
    _boxController.forward();
  }

  void dismissSlideContainerAnimation() {
    _boxController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _addSizeConfig();
    return SlideTransition(
        position: widget._slideDownAnimation, child: _buildMenuContent());
  }

  Widget _buildMenuContent() {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: _padding,
      color: Colors.white,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: createMenuItems(context),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> createMenuItems(BuildContext context) {
    return kMenu.map((menuItem) {
      int index = kMenu.indexOf(menuItem);
      return Expanded(
        child: MobileMenuItem(
          label: menuItem,
          index: index,
          height: _menuItemHeight,
          isHovered: _menuItemHover[index],
          onTap: () => widget.onMenuItemTapped(index),
        ),
      );
    }).toList();
  }
}
