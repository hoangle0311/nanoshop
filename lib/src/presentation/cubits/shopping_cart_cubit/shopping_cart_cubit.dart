import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';

import '../../../data/responses/cart/cart.dart';

part 'shopping_cart_state.dart';

class ShoppingCartCubit extends Cubit<ShoppingCartState> {
  ShoppingCartCubit()
      : super(
          const ShoppingCartState(),
        );

  void onRemoveCart({
    required Cart cart,
  }) {
    List<Cart> _listCart = List.of(state.listCart);
    _listCart.remove(cart);

    emit(
      state.copyWith(
        listCart: List.of(_listCart),
      ),
    );
  }

  void onSetChecking({
    required Cart cart,
  }) {
    List<Cart> _listCart = state.listCart.map(
      (e) {
        if (e == cart) {
          return e.copyWith(
            isChecking: !e.isChecking,
          );
        }

        return e;
      },
    ).toList();

    emit(
      state.copyWith(
        listCart: List.of(_listCart),
      ),
    );
  }

  void onSetQuantityCart({
    required Product product,
    required int quantity,
  }) {
    List<Cart> _listCarts = [];

    Cart cart = Cart.fromProduct(product: product);

    if (state.listCart.isNotEmpty) {
      bool isAddedNew = false;

      _listCarts.addAll(
        state.listCart.map(
          (e) {
            if (e.id == cart.id) {
              isAddedNew = true;
              return e.copyWith(
                total: quantity,
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

  onMinusAmountCart({
    required Cart cart,
  }) {
    List<Cart> _listCart = state.listCart.map(
      (e) {
        if (e == cart && e.total >= 2) {
          return e.copyWith(
            total: e.total - 1,
          );
        }

        return e;
      },
    ).toList();

    emit(
      state.copyWith(
        listCart: List.of(_listCart),
      ),
    );
  }

  onAddAmountCart({
    required Cart cart,
  }) {
    List<Cart> _listCart = state.listCart.map(
      (e) {
        if (e == cart) {
          return e.copyWith(
            total: e.total + 1,
          );
        }

        return e;
      },
    ).toList();

    emit(
      state.copyWith(
        listCart: List.of(_listCart),
      ),
    );
  }

  void onAddCart({
    required Product product,
    int quantity = 1,
  }) {
    List<Cart> _listCarts = [];

    Cart cart = Cart.fromProduct(product: product);

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

  void onClearShoppingCart() {
    emit(
      state.copyWith(
        listCart: [],
      ),
    );
  }
}
