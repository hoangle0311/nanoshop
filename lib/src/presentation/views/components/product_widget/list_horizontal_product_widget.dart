import 'package:flutter/material.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../../config/styles/app_color.dart';
import '../../../../config/styles/app_text_style.dart';
import '../../../../core/utils/helper/convert_price.dart';
import '../../../ui/detail_product/sc_detail_product.dart';
import '../widgets/add_favourite_product_widget.dart';
import '../widgets/star_with_rate_count.dart';

class ListHorizontalProductWidget extends StatelessWidget {
  final List<Product> products;

  _itemProduct(
    Product product,
    BuildContext context,
  ) {
    var imageUrl =
        "http://plpharma.nanoweb.vn/mediacenter/" +
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
        margin: const EdgeInsets.only(left: 10),
        child: Container(
          width: 252,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MarginBottom10(
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(6),
                  //     child: Image.asset(
                  //       model.url,
                  //       fit: BoxFit.cover,
                  //       height: 252,
                  //     ),
                  //   ),
                  // ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 252,
                      child: LoadImageFromUrlWidget(
                        imageUrl: imageUrl,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? '',
                          maxLines: 2,
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
                          rateCount: double.parse(product.productInfo != null ? product.productInfo!.totalRating ?? '0.0' : '0').round().toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Positioned(
              //   top: 5,
              //   left: 5,
              //   child: FavouriteIconWidget(
              //     iconSize: 40,
              //     valueChanged: (value) {},
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  const ListHorizontalProductWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
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
