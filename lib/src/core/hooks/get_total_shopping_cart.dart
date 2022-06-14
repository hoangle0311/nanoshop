import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';

String getTotalPriceShoppingCart(BuildContext context) {
  var bloc = context.read<ShoppingCartCubit>();

  var listCart = bloc.state.listCart;

  var total = 0;
  for (var element in listCart) {
    total += (element.total) * double.parse(element.price ?? '0').round();
  }

  return total.toString();
}
