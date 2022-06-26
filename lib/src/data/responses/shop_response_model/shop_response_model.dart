import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/shop/shop.dart';

part 'shop_response_model.g.dart';

@JsonSerializable()
class ShopResponseModel {
  int? code;
  List<Shop>? data;
  String? message;
  String? error;

  ShopResponseModel({
    this.code,
    this.data,
    this.message,
    this.error,
  });

  factory ShopResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ShopResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShopResponseModelToJson(this);
}
