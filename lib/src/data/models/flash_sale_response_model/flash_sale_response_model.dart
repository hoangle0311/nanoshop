import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/flash_sale/flash_sale.dart';

part 'flash_sale_response_model.g.dart';

@JsonSerializable()
class FlashSaleResponseModel {
  int? code;
  List<FlashSale>? data;
  String? message;
  String? error;

  FlashSaleResponseModel({this.code, this.data, this.message, this.error});

  factory FlashSaleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FlashSaleResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlashSaleResponseModelToJson(this);
}
