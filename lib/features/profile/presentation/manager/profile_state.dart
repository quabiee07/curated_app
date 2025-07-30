
import 'package:curated_app/features/profile/domain/model/payload/update_user_payload.dart';
import 'package:curated_app/features/profile/domain/model/profile.dart';
import 'package:image_picker/image_picker.dart';

class ProfileState {
  List<XFile> profileImage = [];
  Profile? profile;
  bool isUpdated = false;
  bool isUpdating = false;

  UpdateUserPayload toState(String fullname, email) {
    return UpdateUserPayload(
      name: fullname,
      email: email,
      profileImage: profileImage,
    );
  }
}
