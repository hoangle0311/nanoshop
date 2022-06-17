import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/data/models/cart/cart.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';
import 'package:nanoshop/src/domain/entities/payment/payment.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/domain/entities/transport/transport.dart';

import '../../domain/entities/bank/bank.dart';

class CheckoutParam extends Equatable {
  final String token;
  final String? discountCode;
  final Bank bank;
  final String userId;
  final Address address;
  final Payment payment;
  final Transport transport;
  final List<Cart> listProduct;

  const CheckoutParam({
    required this.token,
    required this.listProduct,
    this.bank = Bank.empty,
    this.discountCode,
    required this.userId,
    required this.address,
    required this.payment,
    required this.transport,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['products'] = listProduct.map(
      (e) {
        Map<String, dynamic> mapCart = {};

        mapCart['id'] = e.id;
        mapCart['qty'] = e.total;

        return mapCart;
      },
    ).toList();

    if (discountCode != null) {
      data['discount_code'] = discountCode;
    }
    data['user_id'] = userId;
    if (bank != Bank.empty) {
      data['bank_id'] = bank.id;
    }
    data['Billing'] = {
      'sex': address.sex,
      'name': address.name,
      'phone': address.phone,
      'city': address.city,
      'district': address.district,
      'ward': address.ward,
      'address': address.address,
    };

    data['Shipping'] = {
      'sex': address.sex,
      'name': address.name,
      'phone': address.phone,
      'city': address.city,
      'district': address.district,
      'ward': address.ward,
      'address': address.address,
    };

    data['Orders'] = {
      'payment_method': payment.id,
      'transport_method': transport.id,
    };

    return data;
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
