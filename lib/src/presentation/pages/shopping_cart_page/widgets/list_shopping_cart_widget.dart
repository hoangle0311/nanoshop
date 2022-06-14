import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'shopping_cart_list_tile.dart';

class ListShoppingCartWidget extends StatelessWidget {
  const ListShoppingCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
      builder: (context, state) {
        if (state.listCart.isNotEmpty) {
          return ListView.builder(
            itemCount: state.listCart.length,
            itemBuilder: ((context, index) {
              return ShoppingCartListTile(
                cart: state.listCart[index],
                onRemoveItem: () {},
              );
            }),
          );
        }

        return const Center(
          child: Text(
            'Giỏ hàng trống',
          ),
        );
      },
    );
  }
}
