import 'package:curated_app/features/auth/application/auth_service.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/presentation/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  setPathUrlStrategy();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));

  final sharedPreferences = await getIt.getAsync<SharedPreferences>();
  getIt.registerSingleton<AuthService>(AuthService(sharedPreferences));

  runApp(const MyApp());
}
