

import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/data/models/discount/discount_model.dart';

import '../../../domain/entities/discount/discount_data.dart';


part 'list_discount_response_model.g.dart';

@JsonSerializable()
class ListDiscountResponseModel {
  int? code;
  List<DiscountModel>? data;
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
