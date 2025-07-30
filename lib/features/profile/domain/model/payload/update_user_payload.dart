import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UpdateUserPayload {
  String name;
  String email;
  List<XFile> profileImage;

    UpdateUserPayload({
    required this.name,
    required this.email,
    required this.profileImage,
  });
}
