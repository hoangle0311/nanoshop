import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/core/utils/helper/convert_price.dart';
import 'package:nanoshop/src/domain/entities/discount/discount_data.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../core/params/token_param.dart';
import '../../cubits/get_list_coupon/get_list_coupon_cubit.dart';

class ListCoupon extends StatelessWidget {
  const ListCoupon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<GetListCouponCubit>()
        ..onGetListVoucher(
          injector<TokenParam>(),
        ),
      child: Scaffold(
        appBar: const PageAppBar(
          title: 'Danh sách mã giảm giá',
        ),
        body: BlocBuilder<GetListCouponCubit, GetListCouponState>(
          builder: (context, state) {
            if (state.status == GetListCouponStatus.loading &&
                state.listVoucher.isEmpty) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (state.listVoucher.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: state.listVoucher
                      .map(
                        (e) => _Voucher(
                          discountData: e,
                        ),
                      )
                      .toList(),
                ),
              );
            }

            return Center(
              child: Text(
                'Chưa có mã giảm giá nào',
                style: TextStyleApp.textStyle3.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Voucher extends StatelessWidget {
  final DiscountData discountData;

  const _Voucher({
    Key? key,
    required this.discountData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pop(
          discountData,
        );
      },
      child: Card(
        child: ListTile(
          title: Text(
            "Tên khuyến mãi : " + (discountData.name ?? ''),
            style: TextStyleApp.textStyle3.copyWith(
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            "Mã khuyến mãi : " + (discountData.discountCode ?? ''),
            style: TextStyleApp.textStyle2.copyWith(
              color: AppColors.black,
              fontSize: 14,
            ),
          ),
          trailing: Text(
            convertPrice(double.parse(discountData.couponValue ?? '0')),
            style: TextStyleApp.textStyle2.copyWith(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
