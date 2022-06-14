import 'package:json_annotation/json_annotation.dart';

import '../product/product.dart';

part 'flash_sale.g.dart';

@JsonSerializable()
class FlashSale {
  @JsonKey(name: "promotion_id")
  String? promotionId;
  String? enddate;
  @JsonKey(name: "image_path")
  String? imagePath;
  @JsonKey(name: "image_name")
  String? imageName;
  List<Product>? products;

  FlashSale({
    this.promotionId,
    this.enddate,
    this.imagePath,
    this.imageName,
    this.products,
  });

  factory FlashSale.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleFromJson(json);

  Map<String, dynamic> toJson() => _$FlashSaleToJson(this);
}
