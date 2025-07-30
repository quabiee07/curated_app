import 'package:curated_app/core/presentation/utils/routes.dart';
import 'package:curated_app/core/presentation/widgets/menu_button.dart';
import 'package:curated_app/features/home/presentation/manager/home_provider.dart';
import 'package:curated_app/features/home/presentation/screens/menu.dart';
import 'package:flutter/material.dart';
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
        context.pushNamed(routeName);
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
          appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: [
            MenuButton(
              onPressed: onMenuTapped,
              hasMenuTapped: _isDrawerOpen,
            ),
            const Gap(20)
          ]),
          body: Stack(
            children: [
              Container(),
              MenuPage(
                onMenuItemTapped: (index) =>
                    _handleNavigation(kMenuRoutes[index]),
                animation: _menuController.view,
              ),
            ],
          ));
    });
  }
}
