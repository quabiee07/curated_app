import 'package:curated_app/core/presentation/manager/theme_provider.dart';
import 'package:curated_app/core/presentation/theme/app_theme.dart';
import 'package:curated_app/core/presentation/utils/app_router.dart';
import 'package:curated_app/features/home/presentation/manager/home_provider.dart';
import 'package:curated_app/features/post/presentation/manager/post_provider.dart';
import 'package:curated_app/features/profile/presentation/manager/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget with AppTheme {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(builder: (_, provider, __) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  provider.isDark ? Brightness.light : Brightness.dark,
            ),
          );

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Curated',
            theme: provider.theme,
            darkTheme: provider.darkThemeData,
            routerConfig: AppRouter().router,
          );
        }),
      ),
    );
  }
}
