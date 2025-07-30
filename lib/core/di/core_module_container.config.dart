// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:curated_app/core/di/core_module.dart' as _i629;
import 'package:curated_app/features/auth/data/remote/services/auth_api_service.dart'
    as _i596;
import 'package:curated_app/features/auth/data/repository/auth_repository_impl.dart'
    as _i314;
import 'package:curated_app/features/auth/di/auth_module.dart' as _i113;
import 'package:curated_app/features/auth/domain/repository/auth_repository.dart'
    as _i344;
import 'package:curated_app/features/feedback/data/remote/service/feedback_api_service.dart'
    as _i429;
import 'package:curated_app/features/feedback/data/repository/feedback_repository_impl.dart'
    as _i106;
import 'package:curated_app/features/feedback/di/feedback_module.dart' as _i85;
import 'package:curated_app/features/feedback/domain/repository/feedback_repository.dart'
    as _i723;
import 'package:curated_app/features/home/data/remote/services/home_api_service.dart'
    as _i60;
import 'package:curated_app/features/home/data/repository/home_repository_impl.dart'
    as _i811;
import 'package:curated_app/features/home/di/home_module.dart' as _i299;
import 'package:curated_app/features/home/domain/repository/home_repository.dart'
    as _i463;
import 'package:curated_app/features/post/data/remote/services/post_api_service.dart'
    as _i639;
import 'package:curated_app/features/post/data/repository/post_repository_impl.dart'
    as _i275;
import 'package:curated_app/features/post/di/post_module.dart' as _i202;
import 'package:curated_app/features/post/domain/repository/post_repository.dart'
    as _i831;
import 'package:curated_app/features/profile/data/remote/services/profile_api_service.dart'
    as _i58;
import 'package:curated_app/features/profile/data/repository/profile_repository_impl.dart'
    as _i41;
import 'package:curated_app/features/profile/di/profile_module.dart' as _i795;
import 'package:curated_app/features/profile/domain/repository/profile_repository.dart'
    as _i1027;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    final homeModule = _$HomeModule();
    final postModule = _$PostModule();
    final authModule = _$AuthModule();
    final feedbackModule = _$FeedbackModule();
    final profileModule = _$ProfileModule();
    gh.factory<_i361.Dio>(() => coreModule.dio());
    gh.factoryAsync<_i460.SharedPreferences>(() => coreModule.preferences());
    gh.factory<_i60.HomeApiService>(() => homeModule.api);
    gh.factory<_i639.PostApiService>(() => postModule.api);
    gh.factory<_i596.AuthApiService>(() => authModule.api);
    gh.factory<_i429.FeedbackApiService>(() => feedbackModule.api);
    gh.factory<_i58.ProfileApiService>(() => profileModule.api);
    gh.lazySingleton<_i344.AuthRepository>(() => _i314.AuthRepositoryImpl());
    gh.lazySingleton<_i1027.ProfileRepository>(
        () => _i41.ProfileRepositoryImpl());
    gh.lazySingleton<_i723.FeedbackRepository>(
        () => _i106.FeedbackRepositoryImpl());
    gh.lazySingleton<_i831.PostRepository>(() => _i275.PostRepositoryImpl());
    gh.lazySingleton<_i463.HomeRepository>(() => _i811.HomeRepositoryImpl());
    return this;
  }
}

class _$CoreModule extends _i629.CoreModule {}

class _$HomeModule extends _i299.HomeModule {}

class _$PostModule extends _i202.PostModule {}

class _$AuthModule extends _i113.AuthModule {}

class _$FeedbackModule extends _i85.FeedbackModule {}

class _$ProfileModule extends _i795.ProfileModule {}
