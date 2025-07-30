import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/domain/validation/validation.dart';
import 'package:curated_app/core/presentation/manager/custom_provider.dart';
import 'package:curated_app/features/post/domain/repository/post_repository.dart';
import 'package:curated_app/features/post/domain/usecases/create_post_usecase.dart';
import 'package:curated_app/features/post/domain/usecases/delete_post_usecase.dart';
import 'package:curated_app/features/post/domain/usecases/get_post_details_usecase.dart';
import 'package:curated_app/features/post/domain/usecases/get_posts_usecase.dart';
import 'package:curated_app/features/post/domain/usecases/update_post_usecase.dart';
import 'package:curated_app/features/post/presentation/manager/post_state.dart';

class PostProvider extends CustomProvider {
  final _repo = getIt.get<PostRepository>();
  final state = PostState();

  setTitle(String title) {
    state.title = title;
    state.titleError = title.validateName();
    notifyListeners();
  }

  setDescription(String description) {
    state.description = description;
    state.descriptionError = description.validateName();
    notifyListeners();
  }

  setUrl(String url) {
    state.url = url;
    state.urlError = url.validateUrl();
    notifyListeners();
  }

  // setImage(String image) {
  //   state.image = image;
  //   state.imageError = image.validateImage();
  //   notifyListeners();
  // }

  createPost() {
    state.isPosting = true;
    notifyListeners();

    CreatePostUsecase(_repo, state.toState()).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });
      if (result != null) {
        add(result);
      }
      state.isPosting = false;
      notifyListeners();
    });
  }

  getPosts() {
    onLoad();

    GetPostUsecase(_repo, null).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });
      if (result != null) {
        add(result);
        state.posts = result;
      }
      onLoad();
    });
  }

  getPostDetails(String postId) {
    onLoad();

    GetPostDetailsUsecase(_repo, postId).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });
      if (result != null) {
        add(result);
        state.postDetail = result;
      }
      onLoad();
    });
  }

  updatePost(String postId) {
    onLoad();

    UpdatePostUsecase(_repo, postId, state.toState()).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });
      if (result != null) {
        add(result);
      }
      onLoad();
    });
  }

  deletePost(String postId) {
    onLoad();

    DeletePostUsecase(_repo, postId).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);
        return null;
      });
      if (result != null) {
        add(result);
      }
      onLoad();
    });
  }
}
