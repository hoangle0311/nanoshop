import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';
import '../../../../core/utils/helper/convert_price.dart';
import '../../../ui/detail_product/sc_detail_product.dart';
import '../widgets/add_favourite_product_widget.dart';
import '../widgets/border_gardient.dart';
import '../widgets/star_with_rate_count.dart';

class ListFlashSaleWidget extends StatelessWidget {
  final List<Product> products;

  _itemProduct(
    Product product,
    BuildContext context,
  ) {
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
        width: 146,
        margin: EdgeInsets.symmetric(horizontal: 7.5),
        child: Column(
          children: [
            Container(
              height: 134,
              child: Stack(
                children: [
                  BorderGradient(
                    strokeWidth: 1,
                    radius: 4,
                    gradient: LinearGradient(
                      colors: [Colors.red, AppColors.primaryColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ScDetailProduct(product: product),
                        ),
                      );
                    },
                    child: Container(
                      height: 125,
                      width: 144,
                      margin: EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LoadImageFromUrlWidget(
                          imageUrl: imageUrl,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 12,
                    left: 12,
                    child: LinearPercentIndicator(
                      width: 120.0,
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 14.0,
                      percent: int.parse(product.totalSell ?? '0') / 100,
                      center: Text(
                        "Đã bán: ${product.totalSell ?? 0}".toUpperCase(),
                        style: TextStyleApp.textStyle2.copyWith(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.red,
                      backgroundColor: Colors.red.withOpacity(0.3),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 12,
                    child: Image.asset(ImagePath.fire),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              convertPrice(double.parse(product.price ?? '0').round()),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyleApp.textStyle2.copyWith(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
      // child: Container(
      //   margin: const EdgeInsets.only(left: 10),
      //   child: Container(
      //     width: 252,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(6),
      //     ),
      //     child: Stack(
      //       children: [
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             // MarginBottom10(
      //             //   child: ClipRRect(
      //             //     borderRadius: BorderRadius.circular(6),
      //             //     child: Image.asset(
      //             //       model.url,
      //             //       fit: BoxFit.cover,
      //             //       height: 252,
      //             //     ),
      //             //   ),
      //             // ),
      //             ClipRRect(
      //               borderRadius: BorderRadius.circular(10),
      //               child: Container(
      //                 height: 252,
      //                 child: LoadImageFromUrlWidget(
      //                   imageUrl: imageUrl,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Container(
      //               padding: const EdgeInsets.symmetric(
      //                 horizontal: 10,
      //               ),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     product.name ?? '',
      //                     maxLines: 2,
      //                     overflow: TextOverflow.ellipsis,
      //                     style: TextStyleApp.textStyle1.copyWith(
      //                       color: AppColors.black,
      //                       fontSize: 13,
      //                       fontWeight: FontWeight.w400,
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text(
      //                     convertPrice(
      //                         double.parse(product.price ?? '0').round()),
      //                     overflow: TextOverflow.ellipsis,
      //                     textAlign: TextAlign.start,
      //                     maxLines: 1,
      //                     style: TextStyleApp.textStyle2.copyWith(
      //                       color: AppColors.primaryColor,
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text(
      //                     convertPrice(
      //                         double.parse(product.priceMarket ?? '0').round()),
      //                     overflow: TextOverflow.ellipsis,
      //                     maxLines: 1,
      //                     textAlign: TextAlign.end,
      //                     style: TextStyleApp.textStyle2.copyWith(
      //                       color: AppColors.dividerColor,
      //                       decoration: TextDecoration.lineThrough,
      //                     ),
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                   StarWithRateCount(
      //                     rateCount: double.parse(product.totalRating != null ? product.totalRating ?? '0.0' : '0').toString(),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //         // Positioned(
      //         //   top: 5,
      //         //   left: 5,
      //         //   child: FavouriteIconWidget(
      //         //     iconSize: 40,
      //         //     valueChanged: (value) {},
      //         //   ),
      //         // ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  const ListFlashSaleWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _itemProduct(
            products[index],
            context,
          );
        },
      ),
    );
    ;
  }
}
