import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/features/post/domain/model/created_post_model.dart';
import 'package:curated_app/features/post/domain/model/payload/create_post_payload.dart';
import 'package:curated_app/features/post/domain/model/post_data_model.dart';

abstract class PostRepository {
  Future<ApiResult<CreatedPost>> createPost(CreatePostPayload payload);
  Future<ApiResult<List<PostDataModel>>> getPosts();
  Future<ApiResult<PostDataModel>> getPostById(String id);
  Future<ApiResult<CreatedPost>> deletePost(String id);
  Future<ApiResult<CreatedPost>> updatePost(String id, CreatePostPayload payload);

}