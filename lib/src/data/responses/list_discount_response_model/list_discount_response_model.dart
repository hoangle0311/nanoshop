

import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/discount/discount_data.dart';


part 'list_discount_response_model.g.dart';

@JsonSerializable()
class ListDiscountResponseModel {
  int? code;
  List<DiscountData>? data;
  String? message;
  String? error;

  ListDiscountResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory ListDiscountResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ListDiscountResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListDiscountResponseModelToJson(this);
}
