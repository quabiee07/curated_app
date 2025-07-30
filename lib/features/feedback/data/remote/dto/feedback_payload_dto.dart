// To parse this JSON data, do
//
//     final feedbackPayloadDto = feedbackPayloadDtoFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'feedback_payload_dto.g.dart';

FeedbackPayloadDto feedbackPayloadDtoFromJson(String str) => FeedbackPayloadDto.fromJson(json.decode(str));

String feedbackPayloadDtoToJson(FeedbackPayloadDto data) => json.encode(data.toJson());

@JsonSerializable()
class FeedbackPayloadDto {
    @JsonKey(name: "message")
    String message;
    @JsonKey(name: "rating")
    int rating;

    FeedbackPayloadDto({
        required this.message,
        required this.rating,
    });

    factory FeedbackPayloadDto.fromJson(Map<String, dynamic> json) => _$FeedbackPayloadDtoFromJson(json);

    Map<String, dynamic> toJson() => _$FeedbackPayloadDtoToJson(this);
}
