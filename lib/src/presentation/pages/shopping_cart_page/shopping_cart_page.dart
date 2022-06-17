import 'package:flutter/material.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import 'widgets/list_shopping_cart_widget.dart';
import 'widgets/total_price_shopping_cart.dart';

class ShoppingCartPage extends StatelessWidget {
  final bool isShow;

  const ShoppingCartPage({
    Key? key,
    this.isShow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isShow ? PageAppBar(title: 'Giỏ hàng') : SizedBox(),
        Expanded(
          child: ListShoppingCartWidget(),
        ),
        TotalPriceShoppingCart(),
      ],
    );
  }
}
