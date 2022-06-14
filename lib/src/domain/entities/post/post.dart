import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  @JsonKey(name: "news_id")
  String? newsId;
  @JsonKey(name: "news_category_id")
  String? newsCategoryId;
  @JsonKey(name: "news_title")
  String? newsTitle;
  @JsonKey(name: "news_sortdesc")
  String? newsSortdesc;
  String? alias;
  String? status;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "image_path")
  String? imagePath;
  @JsonKey(name: "image_name")
  String? imageName;
  @JsonKey(name: "created_time")
  String? createdTime;
  @JsonKey(name: "news_hot")
  String? newsHot;
  @JsonKey(name: "public_date")
  String? publicdate;
  String? viewed;
  String? poster;
  String? link;

  Post(
      {this.newsId,
      this.newsCategoryId,
      this.newsTitle,
      this.newsSortdesc,
      this.alias,
      this.status,
      this.userId,
      this.imagePath,
      this.imageName,
      this.createdTime,
      this.newsHot,
      this.publicdate,
      this.viewed,
      this.poster,
      this.link});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [];
}
