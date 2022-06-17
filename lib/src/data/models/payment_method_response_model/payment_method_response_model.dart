import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/payment/payment.dart';

part 'payment_method_response_model.g.dart';

@JsonSerializable()
class PaymentMethodResponseModel {
  int? code;
  List<Payment>? data;
  String? message;
  String? error;

  PaymentMethodResponseModel({this.code, this.data, this.message, this.error});

  factory PaymentMethodResponseModel.fromJson(Map<String, dynamic> json) {
    return _$PaymentMethodResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentMethodResponseModelToJson(this);
}