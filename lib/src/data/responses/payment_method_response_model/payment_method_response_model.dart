import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/data/models/payment/payment_model.dart';

import '../../../domain/entities/payment/payment.dart';

part 'payment_method_response_model.g.dart';

@JsonSerializable()
class PaymentMethodResponseModel {
  int? code;
  List<PaymentModel>? data;
  String? message;
  String? error;

  PaymentMethodResponseModel({this.code, this.data, this.message, this.error});

  factory PaymentMethodResponseModel.fromJson(Map<String, dynamic> json) {
    return _$PaymentMethodResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentMethodResponseModelToJson(this);
}