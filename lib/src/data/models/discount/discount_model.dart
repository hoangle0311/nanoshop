import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/discount/discount_data.dart';

part 'discount_model.g.dart';

@JsonSerializable()
class DiscountModel extends DiscountData {
  const DiscountModel({
    String? id,
    String? name,
    String? couponValue,
    String? discountCode,
    String? totalDiscount,
  }) : super(
          id: id,
          name: name,
          couponValue: couponValue,
          discountCode: discountCode,
          totalDiscount: totalDiscount,
        );

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountModelToJson(this);
}
