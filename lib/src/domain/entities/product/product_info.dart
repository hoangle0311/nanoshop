import 'package:json_annotation/json_annotation.dart';

part 'product_info.g.dart';

@JsonSerializable()
class ProductInfo {
  @JsonKey(name: "product_id")
  String? productId;
  @JsonKey(name: "product_sortdesc")
  String? productSortdesc;
  @JsonKey(name: "product_desc")
  String? productDesc;
  @JsonKey(name: "meta_title")
  String? metaTitle;
  @JsonKey(name: "total_rating")
  String? totalRating;
  @JsonKey(name: "total_votes")
  String? totalVotes;
  @JsonKey(name: "shop_store")
  String? shopStore;
  @JsonKey(name: "product_note")
  String? productNote;
  @JsonKey(name: "dynamic_field")
  String? dynamicField;

  ProductInfo({
    this.productId,
    this.productSortdesc,
    this.productDesc,
    this.metaTitle,
    this.totalRating,
    this.totalVotes,
    this.shopStore,
    this.productNote,
    this.dynamicField,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return _$ProductInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}
