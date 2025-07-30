import 'package:curated_app/features/post/domain/model/payload/create_post_payload.dart';
import 'package:curated_app/features/post/domain/model/post_data_model.dart';
import 'package:image_picker/image_picker.dart';

class PostState {
  bool isPosting = false;
  String title = "";
  String? titleError;
  String description = "";
  String? descriptionError;
  String url = "";
  String? urlError;
  List<PostDataModel> posts = [];
  PostDataModel? postDetail;
  List<XFile> images = [];

  CreatePostPayload toState() {
    return CreatePostPayload(
      title: title,
      description: description,
      url: url,
      image: images,
    );
  }
}
