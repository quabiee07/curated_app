import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/features/home/data/remote/services/home_api_service.dart';
import 'package:curated_app/features/home/domain/model/post.dart';
import 'package:curated_app/features/home/domain/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final api = getIt.get<HomeApiService>();

  @override
  Future<ApiResult<HomePostData>> getHomePagePosts() async {
    // try {
      final result = await api.getHomePagePosts(
          token: accessToken, );
      return ApiResult.success(result.data.toDto());
    // } catch (e) {
    //   return ApiResult.failure(e);
    // }
  }
}
