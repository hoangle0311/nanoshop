import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String? id;
  @JsonKey(name: 'cat_id')
  String? catId;
  @JsonKey(name: 'cat_name')
  String? catName;
  @JsonKey(name: 'cat_order')
  String? catOrder;
  @JsonKey(name: 'image_path')
  String? imagePath;
  @JsonKey(name: 'image_name')
  String? imageName;
  @JsonKey(name: 'icon_path')
  String? iconPath;
  @JsonKey(name: 'icon_name')
  String? iconName;

  List<Category>? children;

  Category(
      {this.id,
      this.catId,
      this.catName,
      this.catOrder,
      this.imagePath,
      this.imageName,
      this.iconPath,
      this.iconName,
      this.children});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
