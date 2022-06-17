import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';

part 'add_comment_response_model.g.dart';

@JsonSerializable()
class AddCommentResponseModel {
  int? code;
  String? message;
  String? error;

  factory AddCommentResponseModel.fromJson(Map<String, dynamic> json) {
    return _$AddCommentResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddCommentResponseModelToJson(this);

  AddCommentResponseModel({this.code, this.message, this.error});
}
