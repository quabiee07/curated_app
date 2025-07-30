class FeedbackModel {
    int id;
    String message;
    int rating;
    int userId;
    DateTime createdAt;

    FeedbackModel({
        required this.id,
        required this.message,
        required this.rating,
        required this.userId,
        required this.createdAt,
    });

}
