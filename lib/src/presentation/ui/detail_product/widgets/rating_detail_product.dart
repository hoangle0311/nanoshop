import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/domain/entities/product/product_info.dart';

import '../../../../config/styles/app_text_style.dart';
import '../../../../domain/entities/product/product.dart';
import '../../../../domain/entities/user_login/user_login.dart';
import '../../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../../views/components/rating_star_widget/rating_star_widget.dart';

class RatingDetailProduct extends StatelessWidget {
  final Product product;

  const RatingDetailProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'đánh giá sản phẩm'.toUpperCase(),
              style: TextStyleApp.textStyle2.copyWith(
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // var authBloc = context.read<AuthenticationBloc>();
                            // var authState = authBloc.state;
                            //
                            // if (authState.user == UserLogin.empty) {
                            //   Navigator.of(context)
                            //       .pushNamed(AppRouterEndPoint.LOGIN);
                            // } else {
                            //
                            // }

                            Navigator.of(context).pushNamed(
                              AppRouterEndPoint.SENDCOMMENT,
                              arguments: product,
                            );
                          },
                          child: RatingStarWidget(
                              rating: double.parse(
                            product.productInfo!.totalRating ?? '0',
                          )),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${double.parse(product.productInfo!.totalRating ?? '0').toStringAsFixed(1)}/5',
                          textAlign: TextAlign.center,
                          style: TextStyleApp.textStyle3.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    '(${product.productInfo!.totalVotes} đánh giá)',
                    style: TextStyleApp.textStyle4.copyWith(
                      color: AppColors.black,
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
