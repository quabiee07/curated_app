import 'package:curated_app/features/home/data/remote/services/home_api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/di/core_module_container.dart';

@module
abstract class HomeModule {
  HomeApiService get api => HomeApiService(getIt.get<Dio>());
}