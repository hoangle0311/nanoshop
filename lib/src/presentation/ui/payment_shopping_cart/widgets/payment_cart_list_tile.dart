import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/core/constant/strings/strings.dart';
import 'package:nanoshop/src/data/models/cart/cart.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';
import '../../../../core/utils/helper/convert_price.dart';

class PaymentCartListTile extends StatelessWidget {
  final Cart cart;

  const PaymentCartListTile({
    Key? key,
    required this.cart,
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
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
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
                        ],
                      ),
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
                              cart.getTotalPrice(),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          Strings.amount + ': ',
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          cart.total.toString(),
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
