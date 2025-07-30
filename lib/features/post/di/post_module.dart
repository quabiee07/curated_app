import 'package:curated_app/features/post/data/remote/services/post_api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/di/core_module_container.dart';

@module
abstract class PostModule {
  PostApiService get api => PostApiService(getIt.get<Dio>());
}