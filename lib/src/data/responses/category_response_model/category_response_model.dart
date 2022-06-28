import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/category/category.dart';

part 'category_response_model.g.dart';

@JsonSerializable()
class CategoryResponseModel {
  int? code;
  List<Category>? data;
  String? message;
  String? error;

  CategoryResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryResponseModelToJson(this);
}
