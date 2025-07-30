import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/use_case/use_case.dart';
import 'package:curated_app/features/post/domain/model/created_post_model.dart';
import 'package:curated_app/features/post/domain/model/payload/create_post_payload.dart';
import 'package:curated_app/features/post/domain/repository/post_repository.dart';

class CreatePostUsecase extends UseCase<CreatedPost, CreatePostPayload> {
  final PostRepository repository;

  CreatePostUsecase(this.repository, super.param);

  @override
  Future<ApiResult<CreatedPost>> invoke() {
    return repository.createPost(param);
  }
}
