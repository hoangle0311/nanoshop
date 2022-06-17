import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/utils/helper/convert_price.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/presentation/views/components/rating_star_widget/rating_star_widget.dart';

import '../../../../core/constant/strings/strings.dart';

class NameProductContainer extends StatelessWidget {
  final Product product;

  const NameProductContainer({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleApp.textStyle2.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (product.discountPercent != null &&
                        int.parse(product.discountPercent ?? '0') > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (product.discountPercent ?? '0') + "%",
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                color: HexColor('#F9DF7B').withOpacity(0.1),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  convertPrice(
                                      double.parse(product.price ?? '0')
                                          .round()),
                                  style: TextStyleApp.textStyle7.copyWith(
                                    fontSize: 18,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  convertPrice(
                                      double.parse(product.priceMarket ?? '0')
                                          .round()),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyleApp.textStyle2.copyWith(
                                    color: AppColors.dividerColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 6, vertical: 4),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(4),
                        //   ),
                        //   child: Text(
                        //     'Giảm ${product.discountPercent}%',
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Giá tốt nhất so với các sản phẩm trên thị trường',
                      style: TextStyleApp.textStyle4,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                double.parse(
                                        product.productInfo!.totalRating ?? "0")
                                    .round()
                                    .toString(),
                                style: TextStyleApp.textStyle2,
                              ),
                            ),
                            RatingStarWidget(
                              rating: double.parse(
                                  product.productInfo!.totalRating ?? "0"),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: VerticalDivider(),
                      ),
                      Expanded(
                        child: Text(
                          'Bình luận ${product.productInfo!.totalVotes ?? "0"} ',
                          textAlign: TextAlign.center,
                          style: TextStyleApp.textStyle2,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: VerticalDivider(),
                      ),
                      Expanded(
                        child: Text(
                          'Đã bán ${product.totalSell ?? 0}',
                          textAlign: TextAlign.center,
                          style: TextStyleApp.textStyle2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // MarginRight10(
                      //   child: Image.asset(AssetsPath.insureDetailProductIcon),
                      // ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${Strings.appName} ",
                              style: TextStyleApp.textStyle2.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: "đảm bảo",
                              style: TextStyleApp.textStyle2.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    'Hàng chính hãng',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
