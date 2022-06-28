import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';
import 'package:provider/provider.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';
import '../../../../core/utils/helper/convert_price.dart';
import '../../../../data/responses/cart/cart.dart';

class ShoppingCartListTile extends StatelessWidget {
  final Cart cart;
  final Function()? onRemoveItem;

  const ShoppingCartListTile({
    Key? key,
    required this.cart,
    this.onRemoveItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = Environment.domain +
        '/mediacenter/' +
        (cart.avatarPath ?? '') +
        (cart.avatarName ?? '');

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 5,
            color: AppColors.grey,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    child: LoadImageFromUrlWidget(
                      imageUrl: imageUrl,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    context.read<ShoppingCartCubit>().onSetChecking(
                          cart: cart,
                        );
                  },
                  child: Icon(
                    cart.isChecking
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank,
                    color: cart.isChecking
                        ? AppColors.primaryColor
                        : AppColors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          cart.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyleApp.textStyle6,
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      InkWell(
                        onTap: () {
                          context.read<ShoppingCartCubit>().onRemoveCart(
                                cart: cart,
                              );
                        },
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: AppColors.dividerColor,
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   child: Text(
                  //     'Dung tích: 50g',
                  //     style: TextStyleApp.textStyle4.copyWith(
                  //       color: AppColors.primaryColor,
                  //     ),
                  //   ),
                  // ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          convertPrice(
                            double.parse(cart.price ?? '0').round(),
                          ),
                          style: TextStyleApp.textStyle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          convertPrice(
                              double.parse(cart.priceMarket ?? '0').round()),
                          style: TextStyleApp.textStyle4.copyWith(
                            // fontWeight: FontWeight.bold,
                            color: AppColors.dividerColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<ShoppingCartCubit>()
                              .onMinusAmountCart(cart: cart);
                          // _model.minusQty(newItem: model);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                          ),
                          child: Image.asset(
                            ImagePath.minimizedIcon,
                            width: 6,
                            height: 6,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          cart.total.toString(),
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<ShoppingCartCubit>()
                              .onAddAmountCart(cart: cart);
                          // _model.addQty(newItem: model);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            ImagePath.addIcon,
                            width: 6,
                            height: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


