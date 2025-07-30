import 'package:curated_app/features/home/domain/model/post.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeState {
  bool isLoadMore = false;
  int selectedIndex = 0;
  

  HomePostData? homePostData;
  List<PostModel> posts = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
}
