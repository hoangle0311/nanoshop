import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';

part 'list_post_response_model.g.dart';

@JsonSerializable()
class DetailPostResponseModel {
  int? code;
  Post? data;
  String? message;
  String? error;

  DetailPostResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory DetailPostResponseModel.fromJson(Map<String, dynamic> json) {
    return _$DetailPostResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DetailPostResponseModelToJson(this);
}
