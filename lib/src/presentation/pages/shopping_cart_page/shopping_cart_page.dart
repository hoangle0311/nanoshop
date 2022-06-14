import 'package:flutter/material.dart';

import 'widgets/list_shopping_cart_widget.dart';
import 'widgets/total_price_shopping_cart.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          child: ListShoppingCartWidget(),
        ),
        TotalPriceShoppingCart(),
      ],
    );
  }
}
