part of 'shopping_cart_cubit.dart';

class ShoppingCartState extends Equatable {
  final List<Cart> listCart;

  const ShoppingCartState({
    this.listCart = const [],
  });

  ShoppingCartState copyWith({
    List<Cart>? listCart,
  }) {
    return ShoppingCartState(
      listCart: listCart ?? this.listCart,
    );
  }

  @override
  List<Object> get props => [
        listCart,
      ];
}
