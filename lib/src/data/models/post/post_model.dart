import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Post{

  const PostModel({
    String? newsId,
    String? newsTitle,
    String? newsSortdesc,
    String? newsDesc,
    String? imagePath,
    String? imageName,
}) : super(
    newsId: newsId,
    newsTitle: newsTitle,
    newsSortdesc: newsSortdesc,
    newsDesc: newsDesc,
    imagePath: imagePath,
    imageName: imageName,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}