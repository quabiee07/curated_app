import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/use_case/use_case.dart';
import 'package:curated_app/features/post/domain/model/post_data_model.dart';
import 'package:curated_app/features/post/domain/repository/post_repository.dart';

class GetPostDetailsUsecase extends UseCase<PostDataModel, String> {
  final PostRepository repository;

  GetPostDetailsUsecase(this.repository, super.param);

  @override
  Future<ApiResult<PostDataModel>> invoke() {
    return repository.getPostById(param);
  }
}
 