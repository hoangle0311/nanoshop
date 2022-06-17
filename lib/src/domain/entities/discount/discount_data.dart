import 'package:json_annotation/json_annotation.dart';

part 'discount_data.g.dart';

@JsonSerializable()
class DiscountData {
  String? id;
  String? name;
  @JsonKey(name: "usage_limit")
  String? usageLimit;
  @JsonKey(name: "no_limit")
  String? noLimit;
  @JsonKey(name: "coupon_type")
  String? couponType;
  @JsonKey(name: "coupon_value")
  String? couponValue;
  @JsonKey(name: "category_id")
  String? categoryId;
  @JsonKey(name: "product_id")
  String? productId;
  @JsonKey(name: "value_shipping")
  String? valueShipping;
  @JsonKey(name: "province_id")
  String? provinceId;
  @JsonKey(name: "applies_one")
  String? appliesOne;
  @JsonKey(name: "released_date")
  String? releasedDate;
  @JsonKey(name: "expired_date")
  String? expiredDate;
  @JsonKey(name: "coupon_prefix")
  String? couponPrefix;
  @JsonKey(name: "coupon_number")
  String? couponNumber;
  @JsonKey(name: "created_time")
  String? createdTime;
  String? status;
  @JsonKey(name: "total_discount")
  String? totalDiscount;
  @JsonKey(name: "discount_not_format")
  String? discountNotFormat;
  @JsonKey(name: "total_remain")
  String? totalRemain;

  DiscountData(
      {this.id,
      this.name,
      this.usageLimit,
      this.noLimit,
      this.couponType,
      this.couponValue,
      this.categoryId,
      this.productId,
      this.valueShipping,
      this.provinceId,
      this.appliesOne,
      this.releasedDate,
      this.expiredDate,
      this.couponPrefix,
      this.couponNumber,
      this.createdTime,
      this.status,
      this.totalDiscount,
      this.discountNotFormat,
      this.totalRemain});

  factory DiscountData.fromJson(Map<String, dynamic> json) =>
      _$DiscountDataFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountDataToJson(this);
}
