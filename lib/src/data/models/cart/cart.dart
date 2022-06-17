import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';

class Cart extends Equatable {
  final int total;
  final String? id;
  final String? name;
  final String? price;
  final String? avatarName;
  final String? avatarPath;
  final String? priceMarket;
  final bool isChecking;

  const Cart({
    this.id,
    this.name,
    this.price,
    this.avatarName,
    this.avatarPath,
    this.priceMarket,
    this.total = 0,
    this.isChecking = true,
  });

  double getTotalPrice() {
    return total * double.parse(price ?? '0');
  }

  @override
  List<Object?> get props => [
        id,
        name,
        total,
        isChecking,
      ];

  factory Cart.fromProduct({
    required Product product,
  }) {
    return Cart(
      id: product.id,
      name: product.name,
      avatarName: product.avatarName,
      price: product.price,
      avatarPath: product.avatarPath,
      priceMarket: product.priceMarket,
    );
  }

  Cart copyWith({
    int? total,
    bool? isChecking,
  }) {
    return Cart(
      total: total ?? this.total,
      isChecking: isChecking ?? this.isChecking,
      avatarName: avatarName,
      avatarPath: avatarPath,
      id: id,
      name: name,
      price: price,
      priceMarket: priceMarket,
    );
  }
}
