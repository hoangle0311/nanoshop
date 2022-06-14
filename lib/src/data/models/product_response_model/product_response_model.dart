import 'package:json_annotation/json_annotation.dart';

import '../../../core/utils/log/log.dart';
import 'group_data_response_model.dart';

part 'product_response_model.g.dart';

@JsonSerializable()
class ProductResponseModel {
  int? code;
  GroupData? data;
  String? message;
  String? error;

  ProductResponseModel({this.code, this.data, this.message, this.error});

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ProductResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);
}
