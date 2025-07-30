import 'package:curated_app/core/di/core_module_container.dart';
import 'package:curated_app/core/presentation/manager/custom_provider.dart';
import 'package:curated_app/features/home/domain/repository/home_repository.dart';
import 'package:curated_app/features/home/domain/usecases/home_post_usecase.dart';
import 'package:curated_app/features/home/presentation/manager/home_state.dart';

class HomeProvider extends CustomProvider {
  var state = HomeState();
  final _repo = getIt.get<HomeRepository>();
  int _currentPage = 1;
  final int _limit = 15;

  setIndex(int index) {
    state.selectedIndex = index;
    notifyListeners();
  }

  getHomePagePosts() {
    onLoad();

    HomePostUsecase( _repo).invoke().then((value) {
      final result = value.getOrElse((error) {
        add(error);

        state.refreshController.refreshFailed();
        state.refreshController.loadFailed();
        return null;
      });
      if (result != null) {
        state.homePostData = result;
        state.posts = state.homePostData!.data;
      }
      state.refreshController.loadComplete();
      onLoad();
    });
  }

  loadMore() {
    if (state.posts.length < state.homePostData!.total) {
      _currentPage++;
      state.isLoadMore = true;
      notifyListeners();
      HomePostUsecase( _repo).invoke().then((value) {
        final result = value.getOrElse((error) {
          add(error);
          state.refreshController.loadFailed();
          return null;
        });
        if (result != null) {
          state.posts.addAll(result.data);
        }
        state.isLoadMore = false;
        state.refreshController.loadComplete();
        notifyListeners();
      });
    } else {
      state.refreshController.loadNoData();
    }
  }
}
