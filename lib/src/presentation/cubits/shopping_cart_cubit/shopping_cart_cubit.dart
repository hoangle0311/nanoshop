import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/data/models/cart/cart.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';

part 'shopping_cart_state.dart';

class ShoppingCartCubit extends Cubit<ShoppingCartState> {
  ShoppingCartCubit()
      : super(
          const ShoppingCartState(),
        );

  void onAddCart({
    required Product product,
    int quantity = 1,
  }) {
    Log.i('onAddCart');
    List<Cart> _listCarts = [];

    Cart cart = Cart.fromProduct(product: product);

    Log.i(cart.name.toString());

    if (state.listCart.isNotEmpty) {
      bool isAddedNew = false;

      _listCarts.addAll(
        state.listCart.map(
          (e) {
            if (e.id == cart.id) {
              isAddedNew = true;
              return e.copyWith(
                total: e.total + quantity,
              );
            }

            return e;
          },
        ).toList(),
      );

      if (!isAddedNew) {
        _listCarts.add(
          cart.copyWith(
            total: quantity,
          ),
        );
      }
    } else {
      _listCarts.add(
        cart.copyWith(
          total: quantity,
        ),
      );
    }

    emit(
      state.copyWith(
        listCart: List.of(_listCarts),
      ),
    );
  }
}
