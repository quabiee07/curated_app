import 'package:curated_app/features/feedback/data/remote/service/feedback_api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/di/core_module_container.dart';

@module
abstract class FeedbackModule {
  FeedbackApiService get api => FeedbackApiService(getIt.get<Dio>());
}