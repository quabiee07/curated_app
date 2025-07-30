import 'package:curated_app/features/post/domain/model/post_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_dto.g.dart';


@JsonSerializable()
class PostDto {
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "user_id")
    String userId;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "url")
    String url;
    @JsonKey(name: "image")
    String image;
    @JsonKey(name: "description")
    String description;
    @JsonKey(name: "created_at")
    DateTime createdAt;
    @JsonKey(name: "updated_at")
    DateTime updatedAt;

    PostDto({
        required this.id,
        required this.userId,
        required this.title,
        required this.url,
        required this.image,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
    });

    PostDataModel toDto() {
        return PostDataModel(
            id: id,
            userId: userId,
            title: title,
            url: url,
            image: image,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
        );
    }

    factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);

    Map<String, dynamic> toJson() => _$PostDtoToJson(this);
}
