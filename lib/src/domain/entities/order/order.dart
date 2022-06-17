import 'package:json_annotation/json_annotation.dart';

import '../product/product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: "order_id")
  String? orderId;
  @JsonKey(name: "user_id")
  String? userId;
  @JsonKey(name: "")
  String? siteId;
  @JsonKey(name: "shipping_name")
  String? shippingName;
  @JsonKey(name: "shipping_address")
  String? shippingAddress;
  @JsonKey(name: "shipping_phone")
  String? shippingPhone;
  @JsonKey(name: "shipping_city")
  String? shippingCity;
  @JsonKey(name: "shipping_district")
  String? shippingDistrict;
  @JsonKey(name: "shipping_ward")
  String? shippingWard;
  String? billingName;
  String? billingAddress;
  String? billingPhone;
  String? billingCity;
  String? billingDistrict;
  String? billingWard;
  String? paymentMethod;
  String? transportMethod;
  String? couponCode;
  @JsonKey(name: "order_total")
  String? orderTotal;
  @JsonKey(name: "created_time")
  String? createdTime;
  @JsonKey(name: "modified_time")
  String? modifiedTime;
  String? note;
  String? vat;
  @JsonKey(name: "discount_percent")
  String? discountPercent;
  List<Product>? products;
  @JsonKey(name: "payment_method_name")
  String? paymentMethodName;
  @JsonKey(name: "transport_method_name")
  String? transportMethodName;

  Order(
      {this.orderId,
      this.userId,
      this.siteId,
      this.shippingName,
      this.shippingAddress,
      this.shippingPhone,
      this.shippingCity,
      this.shippingDistrict,
      this.shippingWard,
      this.billingName,
      this.billingAddress,
      this.billingPhone,
      this.billingCity,
      this.billingDistrict,
      this.billingWard,
      this.paymentMethod,
      this.transportMethod,
      this.couponCode,
      this.orderTotal,
      this.createdTime,
      this.modifiedTime,
      this.note,
      this.vat,
      this.discountPercent,
      this.paymentMethodName,
      this.transportMethodName,
      this.products});

  factory Order.fromJson(Map<String, dynamic> json) {
    return _$OrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderToJson(this);

}
