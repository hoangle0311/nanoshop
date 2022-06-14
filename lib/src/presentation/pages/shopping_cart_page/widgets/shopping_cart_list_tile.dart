import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../../data/models/cart/cart.dart';

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
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  child: LoadImageFromUrlWidget(
                    imageUrl: (cart.avatarPath ?? '') + (cart.avatarName ?? ''),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.red,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          cart.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      InkWell(
                        onTap: onRemoveItem,
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        cart.price ?? '',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        cart.priceMarket ?? '',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.black,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.minimize,
                      ),
                    ),
                    Container(
                      child: Text(
                        cart.total.toString(),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
