import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/use_case/use_case.dart';
import 'package:curated_app/features/home/domain/model/post.dart';
import 'package:curated_app/features/home/domain/repository/home_repository.dart';

class HomePostUsecase implements UseCase<HomePostData, void> {
  late HomeRepository repo;
  HomePostUsecase( this.repo);

  @override
  Future<ApiResult<HomePostData>> invoke() {
    return repo.getHomePagePosts();
  }
  
  @override
  void get param => throw UnimplementedError();

}
