import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/core/params/checkout_param.dart';
import 'package:nanoshop/src/core/params/voucher_param.dart';
import 'package:nanoshop/src/data/models/cart/cart.dart';
import 'package:nanoshop/src/domain/entities/payment/payment.dart';
import 'package:nanoshop/src/domain/entities/transport/transport.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'package:nanoshop/src/presentation/ui/payment_shopping_cart/widgets/payment_cart_list_tile.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/remove_focus_widget/remove_focus_widget.dart';
import 'package:nanoshop/src/presentation/views/dialog/dialog_loading.dart';

import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../../core/toast/toast.dart';
import '../../../core/utils/helper/convert_price.dart';
import '../../../domain/entities/address/address.dart';
import '../../../domain/entities/bank/bank.dart';
import '../../blocs/address_bloc/address_bloc.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../cubits/checkout_cubit/checkout_cubit.dart';
import '../../cubits/payment_cubit/payment_cubit.dart';
import '../../cubits/transport_cubit/transport_cubit.dart';
import '../../cubits/voucher_cubit/voucher_cubit.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';

class ResultPayment {
  final Payment? payment;
  final Bank? bank;

  ResultPayment({
    this.bank,
    this.payment,
  });
}

class ScPaymentShoppingCart extends StatelessWidget {
  final List<Cart> listCart;

  const ScPaymentShoppingCart({
    Key? key,
    required this.listCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<VoucherCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<TransportCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<PaymentCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<CheckoutCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<AddressBloc>(),
        ),
      ],
      child: RemoveFocusWidget(
        child: Scaffold(
          appBar: const PageAppBar(
            title: Strings.payment,
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<VoucherCubit, VoucherState>(
                listener: (context, state) {
                  if (state.status == VoucherStatus.success) {
                    Navigator.of(context).maybePop();
                    Toast.showText(
                      state.message ?? '',
                      iconData: Icons.airplane_ticket,
                    );
                  }
                  if (state.status == VoucherStatus.failure) {
                    Navigator.of(context).pop();
                    Toast.showText(
                      state.message ?? '',
                      iconData: Icons.airplane_ticket_sharp,
                    );
                  }
                  if (state.status == VoucherStatus.loading) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return const Dialog(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: DialogLoading(),
                        );
                      },
                    );
                  }
                },
              ),
              BlocListener<CheckoutCubit, CheckoutState>(
                listener: (context, state) {
                  if (state.status == CheckoutStatus.loading) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return const Dialog(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: DialogLoading(),
                        );
                      },
                    );
                  }

                  if (state.status == CheckoutStatus.success) {
                    Navigator.of(context).maybePop();
                    Toast.showText(
                      'Đặt hàng thành công',
                    );

                    context.read<ShoppingCartCubit>().onClearShoppingCart();

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRouterEndPoint.HOME,
                      (router) => false,
                    );
                  }

                  if (state.status == CheckoutStatus.failure) {
                    Navigator.of(context).maybePop();
                    Toast.showText(
                      "Lỗi",
                    );
                  }
                },
              ),
            ],
            child: _Body(
              listCart: listCart,
            ),
          ),
          bottomNavigationBar: _BottomNav(
            listCart: listCart,
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final List<Cart> listCart;

  const _BottomNav({
    Key? key,
    required this.listCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavText(
      title: Strings.buyNow,
      onTap: () {
        var stateAddress = context.read<AddressBloc>().state;
        var stateVoucher = context.read<VoucherCubit>().state;
        var stateTransport = context.read<TransportCubit>().state;
        var statePayment = context.read<PaymentCubit>().state;
        if (stateAddress.addressPayment != Address.empty &&
            stateTransport.transport != Transport.empty &&
            statePayment.payment != Payment.empty) {
          context.read<CheckoutCubit>().onCheckout(
                CheckoutParam(
                  discountCode: stateVoucher.voucherString,
                  bank: statePayment.bank,
                  token: injector<TokenParam>().token,
                  listProduct: listCart,
                  userId: injector<AuthenticationBloc>().state.user.userId!,
                  address: stateAddress.addressPayment,
                  payment: statePayment.payment,
                  transport: stateTransport.transport,
                ),
              );
        } else {
          if (stateAddress.addressPayment == Address.empty) {
            Toast.showText('Vui lòng chọn địa chỉ nhận hàng');
            return;
          }
          if (stateTransport.transport == Transport.empty) {
            Toast.showText('Vui lòng chọn đơn vị vận chuyển');
            return;
          }
          if (statePayment.payment == Payment.empty) {
            Toast.showText('Vui lòng chọn phương thức thanh toán');
            return;
          }
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  final List<Cart> listCart;

  const _Body({
    Key? key,
    required this.listCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            listCart.length,
            (index) {
              return PaymentCartListTile(
                cart: listCart[index],
              );
            },
          ),
          const _Voucher(),
          const _Transport(),
          const _Address(),
          const _Payment(),
          _TotalPriceShoppingCart(
            listCart: listCart,
          ),
        ],
      ),
    );
  }
}

class _TotalPriceShoppingCart extends StatelessWidget {
  final List<Cart> listCart;

  int getTotalPriceShoppingCart() {
    var total = 0;
    for (var element in listCart) {
      total += element.getTotalPrice().round();
    }

    return total;
  }

  const _TotalPriceShoppingCart({
    Key? key,
    required this.listCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportCubit, TransportState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tiền tạm tính :',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    convertPrice(getTotalPriceShoppingCart()),
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tiền vận chuyển :',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    convertPrice(state.transport.price ?? 0),
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng cộng :',
                    style: TextStyleApp.textStyle1.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    convertPrice(getTotalPriceShoppingCart() +
                        (state.transport.price ?? 0)),
                    style: TextStyleApp.textStyle1.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Payment extends StatelessWidget {
  const _Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return _ContainerInformation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleInformation(
                stringChoosing: Strings.choose,
                title: Strings.choosePayment,
                onTap: () {
                  var _paymentCubit = context.read<PaymentCubit>();

                  Navigator.of(context)
                      .pushNamed(
                    AppRouterEndPoint.CHOOSEPAYMENT,
                    arguments: _paymentCubit.state.payment,
                  )
                      .then((value) {
                    if (value != null) {
                      if (value is ResultPayment) {
                        _paymentCubit.onGetResult(
                          payment: value.payment,
                          bank: value.bank,
                        );
                      }
                    }
                  });
                },
                imageSource: ImagePath.walletIconPaymentScreen,
              ),
              const SizedBox(
                height: 25,
              ),
              if (state.payment == Payment.empty)
                Text(
                  'Chưa chọn phương thức thanh toán',
                  style: TextStyleApp.textStyle1.copyWith(
                    color: Colors.black,
                  ),
                ),
              if (state.payment != Payment.empty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.payment.name ?? '',
                      style: TextStyleApp.textStyle1.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              if (state.bank != Bank.empty && state.payment.id == 12)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tên người nhận :',
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          state.bank.name ?? '',
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ngân hàng :',
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          state.bank.bankName ?? '',
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Số tài khoản :',
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          state.bank.number ?? '',
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Address extends StatelessWidget {
  const _Address({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        print(state);
        return _ContainerInformation(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleInformation(
                stringChoosing: Strings.edit,
                title: Strings.chooseAddress,
                onTap: () {
                  Navigator.pushNamed(context, AppRouterEndPoint.ADDADDRESS)
                      .then(
                    (value) {
                      if (value != null) {
                        if (value is Address) {
                          context.read<AddressBloc>().add(
                                AddressPaymentAdd(address: value),
                              );
                        }
                      }
                    },
                  );
                },
                imageSource: ImagePath.locationIconPaymentScreen,
              ),
              const SizedBox(
                height: 25,
              ),
              if (state.addressPayment == Address.empty)
                Text(
                  'Chưa nhập địa chỉ nhận hàng',
                  style: TextStyleApp.textStyle1.copyWith(
                    color: Colors.black,
                  ),
                ),
              if (state.addressPayment != Address.empty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.addressPayment.name,
                          textAlign: TextAlign.center,
                          style: TextStyleApp.textStyle2.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              state.addressPayment.phone,
                              textAlign: TextAlign.center,
                              style: TextStyleApp.textStyle2.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      state.addressPayment.address,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Transport extends StatelessWidget {
  const _Transport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportCubit, TransportState>(
      buildWhen: (pre, cur) {
        return pre.transport != cur.transport;
      },
      builder: (context, state) => _ContainerInformation(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleInformation(
              stringChoosing: Strings.edit,
              title: Strings.chooseTransport,
              onTap: () {
                var _transportCubit = context.read<TransportCubit>();

                Navigator.of(context)
                    .pushNamed(
                  AppRouterEndPoint.CHOOSETRANSPORT,
                  arguments: _transportCubit.state.transport,
                )
                    .then((value) {
                  if (value != null) {
                    if (value is Transport) {
                      _transportCubit.onChooseTransport(value);
                    }
                  }
                });
              },
              imageSource: ImagePath.locationIconPaymentScreen,
            ),
            const SizedBox(
              height: 25,
            ),
            if (state.transport == Transport.empty)
              Text(
                'Chưa chọn đơn vị vận chuyển',
                style: TextStyleApp.textStyle1.copyWith(
                  color: Colors.black,
                ),
              ),
            if (state.transport != Transport.empty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.transport.name ?? '',
                    style: TextStyleApp.textStyle1.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    convertPrice(state.transport.price ?? 0),
                    style: TextStyleApp.textStyle1.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _Voucher extends StatefulWidget {
  const _Voucher({Key? key}) : super(key: key);

  @override
  State<_Voucher> createState() => _VoucherState();
}

class _VoucherState extends State<_Voucher> {
  final TextEditingController _voucherEditingController =
      TextEditingController();

  @override
  void dispose() {
    _voucherEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ContainerInformation(
      child: Column(
        children: [
          _TitleInformation(
            stringChoosing: 'Chọn hoặc nhập mã',
            title: Strings.chooseVoucher,
            onTap: () {},
            imageSource: ImagePath.voucherIconPaymentScreen,
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _voucherEditingController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        hintText: Strings.hintVoucher,
                        hintStyle: TextStyleApp.textStyle1.copyWith(
                          color: AppColors.grey,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyleApp.textStyle1.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<VoucherCubit>().onApplyVoucher(
                            param: VoucherParam(
                              voucherString: _voucherEditingController.text,
                              token: injector<TokenParam>().token,
                            ),
                          );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        Strings.apply,
                        style: TextStyleApp.textStyle5.copyWith(
                          fontSize: 14,
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

class _TitleInformation extends StatelessWidget {
  final String imageSource;
  final String title;
  final String stringChoosing;
  final Function()? onTap;

  const _TitleInformation({
    Key? key,
    required this.imageSource,
    required this.title,
    required this.stringChoosing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(imageSource),
            const SizedBox(
              width: 10,
            ),
            Text(
              title + ": ",
              style: TextStyleApp.textStyle5.copyWith(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              stringChoosing,
              style: TextStyleApp.textStyle4.copyWith(
                fontSize: 14,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContainerInformation extends StatelessWidget {
  final Widget child;

  const _ContainerInformation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey,
            width: 5,
          ),
        ),
      ),
      child: child,
    );
  }
}
