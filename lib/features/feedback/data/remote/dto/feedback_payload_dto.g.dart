// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_payload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackPayloadDto _$FeedbackPayloadDtoFromJson(Map<String, dynamic> json) =>
    FeedbackPayloadDto(
      message: json['message'] as String,
      rating: (json['rating'] as num).toInt(),
    );

Map<String, dynamic> _$FeedbackPayloadDtoToJson(FeedbackPayloadDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'rating': instance.rating,
    };
