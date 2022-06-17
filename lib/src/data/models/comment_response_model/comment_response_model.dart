import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/comment/comment.dart';

import '../../../core/utils/log/log.dart';

part 'comment_response_model.g.dart';

@JsonSerializable()
class CommentResponseModel {
  int? code;
  List<Comment>? data;
  String? message;
  String? error;

  CommentResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CommentResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentResponseModelToJson(this);
}
