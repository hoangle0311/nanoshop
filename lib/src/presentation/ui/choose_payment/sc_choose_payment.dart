import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/domain/entities/payment/payment.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/cubits/transport_cubit/transport_cubit.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../core/constant/strings/strings.dart';
import '../../cubits/payment_cubit/payment_cubit.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';
import '../payment_shopping_cart/sc_payment_shopping_cart.dart';

class ScChoosePayment extends StatelessWidget {
  final Payment payment;

  const ScChoosePayment({
    Key? key,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return injector<PaymentCubit>()
          ..onGetListPayment()
          ..onChoosePayment(
            payment,
          );
      },
      child: Scaffold(
        appBar: const PageAppBar(
          title: Strings.choosePayment,
        ),
        body: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.listPayment.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...List.generate(
                      state.listPayment.length,
                      (index) => _PaymentListTile(
                        payment: state.listPayment[index],
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.status == TransportStatus.loading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            return Center(
              child: Text(
                'Không có đơn vị vận chuyển nào',
                style: TextStyleApp.textStyle1.copyWith(
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if (state.listPayment.isNotEmpty) {
              return BottomNavText(
                title: Strings.apply,
                onTap: () {
                  Navigator.of(context).pop(
                    ResultPayment(
                      payment: state.payment,
                      bank: state.bank,
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _PaymentListTile extends StatelessWidget {
  final Payment payment;

  const _PaymentListTile({
    Key? key,
    required this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PaymentCubit>().onChoosePayment(
              payment,
            );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 5,
              color: AppColors.grey,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          context.read<PaymentCubit>().state.payment == payment
                              ? AppColors.primaryColor
                              : AppColors.grey,
                    ),
                  ),
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          context.read<PaymentCubit>().state.payment == payment
                              ? AppColors.primaryColor
                              : AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        payment.name ?? '',
                        style: TextStyleApp.textStyle1.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (payment.listBank.isNotEmpty &&
                context.read<PaymentCubit>().state.payment == payment)
              ...List.generate(
                payment.listBank.length,
                (index) => InkWell(
                  onTap: () {
                    context.read<PaymentCubit>().onChooseBank(
                          payment.listBank[index],
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.read<PaymentCubit>().state.bank ==
                                      payment.listBank[index]
                                  ? AppColors.primaryColor
                                  : AppColors.grey,
                            ),
                          ),
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.read<PaymentCubit>().state.bank ==
                                      payment.listBank[index]
                                  ? AppColors.primaryColor
                                  : AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Tên ngân hàng: ',
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    payment.listBank[index].bankName ?? '',
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Số tài khoản: ',
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    payment.listBank[index].number ?? '',
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Chủ tài khoản: ',
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    payment.listBank[index].name ?? '',
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Chi nhánh: ',
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    payment.listBank[index].id ?? '',
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
