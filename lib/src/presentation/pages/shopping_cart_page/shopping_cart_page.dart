import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../config/routers/app_router/app_router.dart';
import '../../../core/constant/message/message.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/toast/toast.dart';
import '../../../data/responses/cart/cart.dart';
import '../../../domain/entities/user_login/user_login.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';
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
        isShow
            ? BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
                builder: (context, state) {
                  if (state.listCart.isNotEmpty) {
                    return BottomNavText(
                      title: Strings.buyNow,
                      onTap: () {
                        var authBloc = context.read<AuthenticationBloc>();
                        var authState = authBloc.state;

                        if (authState.user == UserLogin.empty) {
                          Navigator.of(context)
                              .pushNamed(AppRouterEndPoint.LOGIN);
                        } else {
                          final List<Cart> listCart = [];

                          listCart.addAll(state.listCart
                              .where((element) => element.isChecking));

                          if (listCart.isNotEmpty) {
                            Navigator.of(context).pushNamed(
                              AppRouterEndPoint.PAYMENTSHOPPINGCART,
                              arguments: List.of(context
                                      .read<ShoppingCartCubit>()
                                      .state
                                      .listCart)
                                  .where((element) => element.isChecking)
                                  .toList(),
                            );
                          } else {
                            Toast.showText(Message.emptyShoppingCart,
                                iconData: Icons.shopping_basket_rounded);
                          }
                        }
                      },
                    );
                  }

                  return const SizedBox();
                },
              )
            : SizedBox(),
        isShow ? SizedBox(
          height: 50,
        ) : SizedBox()
      ],
    );
  }
}
