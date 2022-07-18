import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Category extends Equatable {
  final String? id;
  @JsonKey(name: 'cat_id')
  final String? catId;
  @JsonKey(name: 'cat_name')
  final String? catName;
  @JsonKey(name: 'cat_order')
  final String? catOrder;
  @JsonKey(name: 'image_path')
  final String? imagePath;
  @JsonKey(name: 'image_name')
  final String? imageName;
  @JsonKey(name: 'icon_path')
  final String? iconPath;
  @JsonKey(name: 'icon_name')
  final String? iconName;

  final List<Category>? children;

  const Category({
    this.id,
    this.catId,
    this.catName,
    this.catOrder,
    this.imagePath,
    this.imageName,
    this.iconPath,
    this.iconName,
    this.children,
  });

  @override
  List<Object?> get props => [
        id,
        catId,
        catName,
      ];
}
