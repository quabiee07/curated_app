class PostDataModel {
    String id;
    String userId;
    String title;
    String url;
    String image;
    String description;
    DateTime createdAt;
    DateTime updatedAt;

    PostDataModel({
        required this.id,
        required this.userId,
        required this.title,
        required this.url,
        required this.image,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

}
