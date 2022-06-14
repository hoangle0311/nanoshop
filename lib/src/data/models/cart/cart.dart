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

  const Cart({
    this.id,
    this.name,
    this.price,
    this.avatarName,
    this.avatarPath,
    this.priceMarket,
    this.total = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        total,
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
  }) {
    return Cart(
      total: total ?? this.total,
      avatarName: avatarName,
      avatarPath: avatarPath,
      id: id,
      name: name,
      price: price,
      priceMarket: priceMarket,
    );
  }
}
