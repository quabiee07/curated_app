import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/features/home/domain/model/post.dart';

abstract class HomeRepository {
  // Future<ApiResult<HomePostData>> getHomePagePosts(int page, int limit);
  Future<ApiResult<HomePostData>> getHomePagePosts();
}
