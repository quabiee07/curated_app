import 'package:curated_app/features/auth/data/remote/services/auth_api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/di/core_module_container.dart';

@module
abstract class AuthModule {
  AuthApiService get api => AuthApiService(getIt.get<Dio>());
}