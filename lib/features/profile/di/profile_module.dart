import 'package:curated_app/features/profile/data/remote/services/profile_api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/di/core_module_container.dart';

@module
abstract class ProfileModule {
  ProfileApiService get api => ProfileApiService(getIt.get<Dio>());
}