import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/domain/entities/order/order.dart';

part 'order_response_model.g.dart';

@JsonSerializable()
class OrderResponseModel {
  int? code;
  List<Order>? data;
  String? message;
  String? error;

  OrderResponseModel({this.code, this.data, this.message, this.error});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return _$OrderResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderResponseModelToJson(this);
}
