import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/api_response/api_result.dart';
import 'package:curated_app/core/domain/utils/utils.dart';
import 'package:curated_app/core/presentation/utils/utils.dart';
import 'package:curated_app/features/post/data/remote/dto/created_post_payload_dto.dart';
import 'package:curated_app/features/post/data/remote/services/post_api_service.dart';
import 'package:curated_app/features/post/domain/model/created_post_model.dart';
import 'package:curated_app/features/post/domain/model/payload/create_post_payload.dart';
import 'package:curated_app/features/post/domain/model/post_data_model.dart';
import 'package:curated_app/features/post/domain/repository/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@LazySingleton(as: PostRepository)
class PostRepositoryImpl extends PostRepository {
  final api = getIt.get<PostApiService>();
  
  @override
  Future<ApiResult<CreatedPost>> createPost(CreatePostPayload payload) async {
    try {
    final files = <MultipartFile>[];
    for (final file in payload.image) {
      if (kIsWeb) {
        final fileBytes = await file.readAsBytes();
        final multipartFile = MultipartFile.fromBytes(
          fileBytes,
          filename: file.path.split('/').last,
          contentType: getContentType(file.path),
        );
        files.add(multipartFile);
      } else {
        final multipartFile = MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split('/').last,
          contentType: getContentType(file.path),
        );
        files.add(multipartFile);
      }
    }
    final result = await api.createPost(
      title: payload.title,
      url: payload.url,
      images: files,
      description: payload.description,
      token: accessToken,
    );
    return ApiResult.success(result.data.toDto());
    } catch (e) {
      return ApiResult.failure('Failed to create post: $e');
    }
  }

  @override
  Future<ApiResult<CreatedPost>> deletePost(String id) async {
    try {
      final result = await api.deletePost(id: id, token: accessToken);
      return ApiResult.success(result.data.toDto());
    } catch (e) {
      return ApiResult.failure('Failed to delete post: $e');
    }
  }

  @override
  Future<ApiResult<PostDataModel>> getPostById(String id) async {
    try {
      final result = await api.getPostById(id: id, token: accessToken);
      return ApiResult.success(result.toDto());
    } catch (e) {
      return ApiResult.failure('Failed to fetch post by ID: $e');
    }
  }

  @override
  Future<ApiResult<List<PostDataModel>>> getPosts() async {
    try {
      final result = await api.getPosts(token: accessToken);
      return ApiResult.success(result.map((e) => e.toDto()).toList());
    } catch (e) {
      return ApiResult.failure('Failed to fetch posts: $e');
    }
  }

  @override
  Future<ApiResult<CreatedPost>> updatePost(
      String id, CreatePostPayload payload) async {
    try {
      final param = CreatedPostPayloadDto(
          title: payload.title,
          url: payload.url,
          image: '',
          description: payload.description);
      final result =
          await api.updatePost(id: id, payload: param, token: accessToken);
      return ApiResult.success(result.data.toDto());
    } catch (e) {
      return ApiResult.failure('Failed to update post: $e');
    }
  }
}
