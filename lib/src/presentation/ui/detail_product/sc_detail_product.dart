import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';
import 'package:nanoshop/src/core/toast/toast.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'package:nanoshop/src/presentation/ui/detail_product/widgets/detail_stats_product_container.dart';
import 'package:nanoshop/src/presentation/ui/detail_product/widgets/name_product_container.dart';

import '../../../domain/entities/product/product.dart';
import '../../views/components/banner_widget/slide_detail_product_widget.dart';

class ScDetailProduct extends StatelessWidget {
  final Product product;

  const ScDetailProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  static const _sizedBoxh5 = SizedBox(
    height: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dividerColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            // controller: _scrollController,
            child: Column(
              children: [
                DetailProductSliderImage(
                  images: [
                    (product.avatarPath ?? '') + (product.avatarName ?? ''),
                    (product.avatarPath ?? '') + (product.avatarName ?? ''),
                    (product.avatarPath ?? '') + (product.avatarName ?? ''),
                    (product.avatarPath ?? '') + (product.avatarName ?? ''),
                    (product.avatarPath ?? '') + (product.avatarName ?? ''),
                    (product.avatarPath ?? '') + (product.avatarName ?? ''),
                  ],
                ),
                _sizedBoxh5,
                NameProductContainer(
                  product: product,
                ),
                // ShareListWidget(
                //   model: state.detailProductModel,
                // ),
                _sizedBoxh5,
                DetailWithTittleProductFragment(
                  title: 'chi tiết sản phẩm',
                  product: product,
                ),
                _sizedBoxh5,
                DetailWithTittleProductFragment(
                  title: 'mô tả sản phẩm',
                  product: product,
                ),
                _sizedBoxh5,
                // RatingProductFragment(
                //   commentBloc: _commentBloc,
                //   model: state.detailProductModel,
                // ),
                // ListHorizontalProduct(
                //   title: 'sản phẩm tương tự',
                // ),
              ],
            ),
          ),
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: AnimatedBuilder(
          //     animation: _colorAnimationController,
          //     builder: (context, child) => Stack(
          //       children: [
          //         Positioned(
          //           top: 0,
          //           left: 0,
          //           right: 0,
          //           bottom: 0,
          //           child: Opacity(
          //             opacity: _opacityTween.value,
          //             child: Image.asset(
          //               AssetsPath.backgroundAppBar,
          //               fit: BoxFit.fill,
          //             ),
          //           ),
          //         ),
          //         Column(
          //           children: [
          //             Container(
          //               height: MediaQuery.of(context).padding.top,
          //             ),
          //             Container(
          //               padding: const EdgeInsets.symmetric(
          //                   horizontal: 10, vertical: 15),
          //               child: Row(
          //                 children: [
          //                   Platform.isAndroid
          //                       ? InkWell(
          //                           onTap: () {
          //                             Get.back();
          //                           },
          //                           child: Icon(
          //                             Icons.arrow_back,
          //                             color: _colorTween.value,
          //                           ),
          //                         )
          //                       : InkWell(
          //                           onTap: () {
          //                             Get.back();
          //                           },
          //                           child: Icon(
          //                             Icons.arrow_back_ios,
          //                             color: _colorTween.value,
          //                           ),
          //                         ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: _BottomNavigationBar(
        product: product,
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final Product product;

  const _BottomNavigationBar({
    Key? key,
    required this.product,
  }) : super(key: key);

  Widget _iconWithText(
    String title,
    IconData iconData, {
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
          ),
          Text(
            title,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var shoppingCartCubit = context.read<ShoppingCartCubit>();

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: AppColors.primaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: _iconWithText(
                      'Chat ngay',
                      Icons.message,
                      onTap: () {},
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: _iconWithText(
                      'Thêm vào giỏ hàng',
                      Icons.shopping_cart,
                      onTap: () {
                        Toast.showText(
                          Message.addCart,
                          iconData: Icons.shopping_cart,
                        );
                        shoppingCartCubit.onAddCart(
                          product: product,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Mua ngay',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
