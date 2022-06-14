import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/data/models/post_response_model/group_data_post.dart';

part 'post_response_model.g.dart';

@JsonSerializable()
class PostResponseModel {
  int? code;
  GroupDataPost? data;
  String? message;
  String? error;

  PostResponseModel({this.code, this.data, this.message, this.error});

  factory PostResponseModel.fromJson(Map<String, dynamic> json) {
    return _$PostResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostResponseModelToJson(this);
}
