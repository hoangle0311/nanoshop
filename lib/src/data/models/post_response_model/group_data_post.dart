import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/post/post.dart';

part 'group_data_post.g.dart';

@JsonSerializable()
class GroupDataPost {
  List<Post>? data;

  GroupDataPost({this.data});

  factory GroupDataPost.fromJson(Map<String, dynamic> json) {
    return _$GroupDataPostFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GroupDataPostToJson(this);
}
