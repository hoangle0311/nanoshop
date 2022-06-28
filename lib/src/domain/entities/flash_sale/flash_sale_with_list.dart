import 'package:json_annotation/json_annotation.dart';

import '../product/product.dart';

part 'flash_sale_with_list.g.dart';

@JsonSerializable()
class FlashSaleWithList {
  @JsonKey(name: "promotion_id")
  final String? promotionId;
  final String? name;
  final String? enddate;
  @JsonKey(name: "image_path")
  final String? imagePath;
  @JsonKey(name: "image_name")
  final String? imageName;
  @JsonKey(name: "data")
  final List<Product>? products;

  const FlashSaleWithList({
    this.promotionId,
    this.enddate,
    this.name,
    this.imagePath,
    this.imageName,
    this.products,
  });

  factory FlashSaleWithList.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleWithListFromJson(json);

  Map<String, dynamic> toJson() => _$FlashSaleWithListToJson(this);
}
