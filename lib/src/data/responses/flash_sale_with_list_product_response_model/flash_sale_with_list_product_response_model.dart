import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';

import '../../../domain/entities/flash_sale/flash_sale.dart';
import 'group_flashsale.dart';

part 'flash_sale_with_list_product_response_model.g.dart';

@JsonSerializable()
class FlashSaleWithListProductResponseModel {
  int? code;
  GroupFlashSale? data;
  String? message;
  String? error;

  FlashSaleWithListProductResponseModel(
      {this.code, this.data, this.message, this.error});

  factory FlashSaleWithListProductResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$FlashSaleWithListProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FlashSaleWithListProductResponseModelToJson(this);
}


