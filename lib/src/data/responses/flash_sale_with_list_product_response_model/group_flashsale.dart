import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/flash_sale/flash_sale.dart';
import '../../../domain/entities/product/product.dart';

part 'group_flashsale.g.dart';

@JsonSerializable()
class GroupFlashSale {
  FlashSale? group;
  List<Product>? data;

  GroupFlashSale({this.group, this.data});

  factory GroupFlashSale.fromJson(
      Map<String, dynamic> json) =>
      _$GroupFlashSaleFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GroupFlashSaleToJson(this);
}