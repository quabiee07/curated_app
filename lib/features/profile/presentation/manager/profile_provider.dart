import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/presentation/manager/custom_provider.dart';
import 'package:curated_app/features/profile/domain/repository/profile_repository.dart';
import 'package:curated_app/features/profile/domain/usecases/get_user_usecase.dart';
import 'package:curated_app/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:curated_app/features/profile/presentation/manager/profile_state.dart';

class ProfileProvider extends CustomProvider {
  final state = ProfileState();
  final _repo = getIt.get<ProfileRepository>();

  getUser() {
    state.isUpdated = false;
    onLoad();

    GetProfileUsecase(_repo, null).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });

      if (result != null) {
        state.profile = result;
        add(result);
      }
      onLoad();
    });
  }

  updateUser(String name, String email) {
    state.isUpdating = true;
    notifyListeners();

    UpdateUserUsecase(_repo, state.toState(name, email)).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });

      if (result != null) {
        state.isUpdated = true;
        add(state);
      }
      state.isUpdating = false;
      notifyListeners();
    });
  }

  chnagePassword() {}
}
