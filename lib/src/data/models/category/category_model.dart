import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/category/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Category {

  @JsonKey(name: "children")
  final List<CategoryModel>? subCategory;

  const CategoryModel({
    String? id,
    String? catId,
    String? catName,
    String? catOrder,
    String? imagePath,
    String? imageName,
    String? iconPath,
    String? iconName,
    this.subCategory,
  }) : super(
          id: id,
          catId: catId,
          catName: catName,
          catOrder: catOrder,
          imagePath: imagePath,
          imageName: imageName,
          iconPath: iconPath,
          iconName: iconName,
          children: subCategory,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
