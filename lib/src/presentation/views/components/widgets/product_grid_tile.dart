import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/blocs/local_product_bloc/local_product_bloc.dart';
import 'package:nanoshop/src/presentation/ui/detail_product/sc_detail_product.dart';
import 'package:nanoshop/src/presentation/views/components/widgets/add_favourite_product_widget.dart';
import 'package:nanoshop/src/presentation/views/components/widgets/star_with_rate_count.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';
import '../../../../core/utils/helper/convert_price.dart';
import '../../../../domain/entities/product/product.dart';
import '../image_widget/load_image_form_url_widget.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;

  const ProductGridTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = "http://plpharma.nanoweb.vn/mediacenter/" +
        ((product.avatarPath ?? '') + (product.avatarName ?? ''));

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScDetailProduct(product: product),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadImageFromUrlWidget(
                  imageUrl: imageUrl,
                  height: MediaQuery.of(context).size.width / 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleApp.textStyle1.copyWith(
                          color: AppColors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        convertPrice(
                            double.parse(product.price ?? '0').round()),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyleApp.textStyle2.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        convertPrice(
                            double.parse(product.priceMarket ?? '0').round()),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        style: TextStyleApp.textStyle2.copyWith(
                          color: AppColors.dividerColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StarWithRateCount(
                        rateCount: double.parse(product.productInfo != null
                                ? product.productInfo!.totalRating ?? '0.0'
                                : '0')
                            .toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //   top: 5,
            //   left: 5,
            //   child: AddFavouriteProductWidget(
            //     product: product,
            //   ),
            // ),
            // Positioned(
            //   top: 5,
            //   right: 5,
            //   child: TagIcon(percent: int.parse(product.discountPercent)),
            // ),
          ],
        ),
      ),
    );
  }
}
