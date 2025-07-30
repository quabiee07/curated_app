class HomePostData {
  int currentPage;
  List<PostModel> data;
  int total;
  int lastPage;

  HomePostData({
    required this.currentPage,
    required this.data,
    required this.total,
    required this.lastPage,
  });
}

class PostModel {
  String id;
  String title;
  String userId;
  String image;
  String url;
  String description;
  PostUser user;
  DateTime createdAt;
  DateTime updatedAt;

  PostModel({
   required this.id,
    required this.title,
    required this.user,
    required this.url,
    required this.userId,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}

class PostUser {
  String id;
  String name;
  String? profileImage;

  PostUser({
    required this.id,
    required this.name,
    required this.profileImage,
  });
}
