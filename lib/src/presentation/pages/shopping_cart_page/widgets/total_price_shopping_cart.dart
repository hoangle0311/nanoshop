import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/hooks/get_total_shopping_cart.dart';
import 'package:nanoshop/src/core/utils/helper/convert_price.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';

class TotalPriceShoppingCart extends StatelessWidget {
  const TotalPriceShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
      builder: (context, state) {
        if (state.listCart.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng cộng :',
                  style: TextStyleApp.textStyle5.copyWith(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  convertPrice(int.parse(getTotalPriceShoppingCart(context))),
                  style: TextStyleApp.textStyle5.copyWith(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
