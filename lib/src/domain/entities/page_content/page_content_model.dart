import 'package:json_annotation/json_annotation.dart';

part 'page_content_model.g.dart';

@JsonSerializable()
class PageContentModel {
  final String? id;
  final String? title;
  final String? content;

  const PageContentModel({
    this.id,
    this.title,
    this.content,
  });

  factory PageContentModel.fromJson(Map<String, dynamic> json) =>
      _$PageContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageContentModelToJson(this);
}
