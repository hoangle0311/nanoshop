import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discount_data.g.dart';

@JsonSerializable()
class DiscountData extends Equatable {
  final String? id;
  final String? name;
  @JsonKey(name: "usage_limit")
  final String? usageLimit;
  @JsonKey(name: "no_limit")
  final String? noLimit;
  @JsonKey(name: "coupon_type")
  final String? couponType;
  @JsonKey(name: "coupon_value")
  final String? couponValue;
  @JsonKey(name: "category_id")
  final String? categoryId;
  @JsonKey(name: "product_id")
  final String? productId;
  @JsonKey(name: "value_shipping")
  final String? valueShipping;
  @JsonKey(name: "province_id")
  final String? provinceId;
  @JsonKey(name: "applies_one")
  final String? appliesOne;
  @JsonKey(name: "released_date")
  final String? releasedDate;
  @JsonKey(name: "expired_date")
  final String? expiredDate;
  @JsonKey(name: "coupon_prefix")
  final String? couponPrefix;
  @JsonKey(name: "coupon_number")
  final String? couponNumber;
  @JsonKey(name: "created_time")
  final String? createdTime;
  final String? status;
  @JsonKey(name: "total_discount")
  final String? totalDiscount;
  @JsonKey(name: "discount_not_format")
  final String? discountNotFormat;
  @JsonKey(name: "total_remain")
  final String? totalRemain;
  @JsonKey(name: "discount_code")
  final String? discountCode;

  static const empty = DiscountData(
    id: '-',
  );

  const DiscountData({
    this.id,
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
    this.discountCode,
    this.discountNotFormat,
    this.totalRemain,
  });

  factory DiscountData.fromJson(Map<String, dynamic> json) =>
      _$DiscountDataFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountDataToJson(this);

  @override
  List<Object?> get props => [
        id,
      ];
}
