import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../config/styles/app_color.dart';
import '../../../config/styles/app_text_style.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/utils/helper/convert_price.dart';
import '../../../domain/entities/product/product.dart';

enum ResultDataType {
  add,
  goScreen,
}

class ResultDataBottomSheetProduct {
  final int total;
  final Product product;
  final ResultDataType type;

  ResultDataBottomSheetProduct({
    required this.total,
    required this.product,
    required this.type,
  });
}

class BottomSheetProduct extends StatefulWidget {
  final Product model;

  const BottomSheetProduct({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _BottomSheetProductState createState() => _BottomSheetProductState();
}

class _BottomSheetProductState extends State<BottomSheetProduct> {
  int total = 1;

  @override
  Widget build(BuildContext context) {
    final imageUrl = Environment.domain +
        '/mediacenter/' +
        (widget.model.avatarPath ?? '') +
        (widget.model.avatarName ?? '');
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      color: Colors.white,
      child: Wrap(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: HexColor('#828282'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Container(
                      height: 128,
                      width: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: HexColor('#E0E0E0'),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LoadImageFromUrlWidget(
                          imageUrl: imageUrl,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.model.name ?? '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleApp.textStyle2.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          convertPrice(
                              double.parse(widget.model.price ?? '0').round()),
                          style: TextStyleApp.textStyle3.copyWith(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          convertPrice(
                              double.parse(widget.model.priceMarket ?? '0')
                                  .round()),
                          style: TextStyleApp.textStyle4.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.dividerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // BorderBottomWidget(
          //   widthBorder: 1,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 10),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         MarginBottom10(
          //           child: Text(
          //             'Dung tích',
          //             style: TextStyleApp.textStyle2.copyWith(
          //               color: AppColor.color11,
          //             ),
          //           ),
          //         ),
          //         RowItemAttribute(),
          //       ],
          //     ),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AmountProduct(
              amount: total,
              onAdd: () {
                total++;
                setState(() {});
              },
              onMinus: () {
                if (total >= 2) {
                  total--;
                  setState(() {});
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: AppColors.primaryColor,
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(
                          ResultDataBottomSheetProduct(
                            product: widget.model,
                            type: ResultDataType.add,
                            total: total,
                          ),
                        );
                        // ProductResponse product = widget.model;
                        // product.total = total;
                        // _model.addTotal(newItem: product);
                        //
                        // Get.back(
                        //   result: false,
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          color: AppColors.accentPrimaryColor.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyleApp.textStyle2.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(
                          ResultDataBottomSheetProduct(
                            product: widget.model,
                            type: ResultDataType.goScreen,
                            total: total,
                          ),
                        );
                        // ProductResponse product = widget.model;
                        // product.total = total;
                        // _model.addTotal(newItem: product);
                        // Get.back(
                        //   result: true,
                        // );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.primaryColor,
                              AppColors.accentPrimaryColor,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            Strings.buyNow,
                            style: TextStyleApp.textStyle5.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AmountProduct extends StatelessWidget {
  final Function()? onMinus;
  final Function()? onAdd;
  final int amount;

  const AmountProduct({
    Key? key,
    this.onMinus,
    this.onAdd,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Số lượng',
          style: TextStyleApp.textStyle2.copyWith(
            color: AppColors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.3),
            border: Border.all(
              color: HexColor("#EBEBEB"),
            ),
            borderRadius: BorderRadius.circular(1),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: onMinus,
                child: const Icon(
                  Icons.remove,
                  size: 14,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.accentPrimaryColor.withOpacity(0.5),
                  border: Border(
                    right: BorderSide(
                      width: 1,
                      color: HexColor("#EBEBEB"),
                    ),
                    left: BorderSide(
                      width: 1,
                      color: HexColor("#EBEBEB"),
                    ),
                  ),
                ),
                child: Text(
                  amount.toString(),
                  style: TextStyleApp.textStyle1.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              InkWell(
                onTap: onAdd,
                child: Icon(
                  Icons.add,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
