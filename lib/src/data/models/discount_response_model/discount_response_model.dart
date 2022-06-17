
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/discount/discount_data.dart';


part 'discount_response_model.g.dart';

@JsonSerializable()
class DiscountResponseModel {
  int? code;
  DiscountData? data;
  String? message;
  String? error;

  DiscountResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory DiscountResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountResponseModelToJson(this);
}
