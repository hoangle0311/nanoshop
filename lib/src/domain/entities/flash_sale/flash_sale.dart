import 'package:json_annotation/json_annotation.dart';

import '../product/product.dart';

part 'flash_sale.g.dart';

@JsonSerializable()
class FlashSale {
  @JsonKey(name: "promotion_id")
  final String? promotionId;
  final String? name;
  final String? enddate;
  @JsonKey(name: "image_path")
  final String? imagePath;
  @JsonKey(name: "image_name")
  final String? imageName;
  final List<Product>? products;

  const FlashSale({
    this.promotionId,
    this.enddate,
    this.name,
    this.imagePath,
    this.imageName,
    this.products,
  });

  factory FlashSale.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleFromJson(json);

  Map<String, dynamic> toJson() => _$FlashSaleToJson(this);
}
