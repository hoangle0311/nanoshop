import 'package:json_annotation/json_annotation.dart';

part 'answer_comment.g.dart';

@JsonSerializable()
class AnswerComment {
  String? id;
  String? content;
  @JsonKey(name: "modified_time")
  String? modifiedTime;
  String? status;
  String? liked;
  String? type;
  @JsonKey(name: "email_phone")
  String? emailPhone;
  String? name;
  String? siteId;

  AnswerComment({
    this.id,
    this.content,
    this.modifiedTime,
    this.status,
    this.liked,
    this.type,
    this.emailPhone,
    this.name,
    this.siteId,
  });

  factory AnswerComment.fromJson(Map<String, dynamic> json) =>
      _$AnswerCommentFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerCommentToJson(this);
}
