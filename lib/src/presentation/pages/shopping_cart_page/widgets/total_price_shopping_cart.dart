import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/core/hooks/get_total_shopping_cart.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';

class TotalPriceShoppingCart extends StatelessWidget {
  const TotalPriceShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
      builder: (context, state) {
        if (state.listCart.isNotEmpty) {
          return Container(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng cộng :',
                  ),
                  Text(
                    getTotalPriceShoppingCart(context),
                  ),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
