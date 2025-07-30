import 'package:image_picker/image_picker.dart';

class CreatePostPayload {
  String title;
  String url;
  List<XFile> image;
  String description;

  CreatePostPayload({
    required this.title,
    required this.url,
    required this.image,
    required this.description,
  });
}
