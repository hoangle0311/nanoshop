import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String? id;
  String? type;
  @JsonKey(name: "object_id")
  String? objectId;
  String? comment;
  @JsonKey(name: "created_time")
  String? createdTime;
  @JsonKey(name: "modified_time")
  String? modifiedTime;
  String? status;
  String? liked;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "site_id")
  String? siteId;
  String? viewed;
  @JsonKey(name: "email_phone")
  String? emailPhone;
  @JsonKey(name: "user_type")
  String? userType;
  String? name;
  @JsonKey(name: "verify_code")
  String? verifyCode;
  @JsonKey(name: "is_image")
  String? isImage;
  String? rating;
  @JsonKey(name: "avatar_path")
  String? avatarPath;
  @JsonKey(name: "avatar_name")
  String? avatarName;

  // List<Null>? images;
  String? items;

  Comment({
    this.id,
    this.rating,
    this.type,
    this.objectId,
    this.comment,
    this.createdTime,
    this.modifiedTime,
    this.status,
    this.liked,
    this.userId,
    this.siteId,
    this.viewed,
    this.emailPhone,
    this.userType,
    this.name,
    this.verifyCode,
    this.isImage,
    this.avatarPath,
    this.avatarName,
    // this.images,
    this.items,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
