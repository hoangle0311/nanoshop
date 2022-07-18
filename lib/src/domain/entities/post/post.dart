import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


class Post extends Equatable {
  @JsonKey(name: "news_id")
  final String? newsId;
  @JsonKey(name: "news_category_id")
  final String? newsCategoryId;
  @JsonKey(name: "news_title")
  final String? newsTitle;
  @JsonKey(name: "news_sortdesc")
  final String? newsSortdesc;
  @JsonKey(name: "news_desc")
  final String? newsDesc;
  final String? alias;
  final String? status;
  @JsonKey(name: "user_id")
  final String? userId;
  @JsonKey(name: "image_path")
  final String? imagePath;
  @JsonKey(name: "image_name")
  final String? imageName;
  @JsonKey(name: "created_time")
  final String? createdTime;
  @JsonKey(name: "news_hot")
  final String? newsHot;
  @JsonKey(name: "public_date")
  final String? publicdate;
  final String? viewed;
  final String? poster;
  final String? link;

  const Post({
    this.newsDesc,
    this.newsId,
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
    this.link,
  });

  static const empty = Post(
    newsId: '-',
  );

  @override
  List<Object?> get props => [
        newsId,
      ];
}
