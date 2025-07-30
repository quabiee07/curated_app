// To parse this JSON data, do
//
//     final feedbackDto = feedbackDtoFromJson(jsonString);

import 'package:curated_app/features/feedback/domain/model/feedback_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'feedback_dto.g.dart';

FeedbackDto feedbackDtoFromJson(String str) =>
    FeedbackDto.fromJson(json.decode(str));

String feedbackDtoToJson(FeedbackDto data) => json.encode(data.toJson());

@JsonSerializable()
class FeedbackDto {
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  Data data;

  FeedbackDto({
    required this.message,
    required this.data,
  });

  factory FeedbackDto.fromJson(Map<String, dynamic> json) =>
      _$FeedbackDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackDtoToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "rating")
  int rating;
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "created_at")
  DateTime createdAt;

  Data({
    required this.id,
    required this.message,
    required this.rating,
    required this.userId,
    required this.createdAt,
  });

  FeedbackModel toModel() {
    return FeedbackModel(
      id: id,
      message: message,
      rating: rating,
      userId: userId,
      createdAt: createdAt,
    );
  }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
