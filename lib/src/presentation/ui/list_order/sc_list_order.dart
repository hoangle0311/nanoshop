import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/utils/helper/convert_price.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/cubits/get_list_order_cubit/get_list_order_cubit.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../core/hooks/use_scroll_controller_for_lazy_loading_order.dart';
import '../../../domain/entities/order/order.dart';
import '../../../domain/entities/product/product.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';

class ScListOrder extends StatelessWidget {
  const ScListOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PageAppBar(
          title: 'Quản lý đơn hàng',
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.grey, width: 1),
                ),
              ),
              child: TabBar(
                unselectedLabelColor: AppColors.dividerColor,
                indicatorColor: AppColors.primaryColor,
                unselectedLabelStyle: TextStyleApp.textStyle2.copyWith(
                  color: AppColors.primaryColor,
                ),
                isScrollable: true,
                indicatorWeight: 3,
                labelColor: AppColors.primaryColor,
                labelStyle: TextStyleApp.textStyle2.copyWith(
                  color: AppColors.primaryColor,
                ),
                tabs: [
                  ItemTabBar(title: "Chờ xác nhận"),
                  ItemTabBar(title: "Chờ lấy hàng"),
                  ItemTabBar(title: "Đang giao"),
                  ItemTabBar(title: "Đã giao"),
                  ItemTabBar(title: "Đã hủy"),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _ListOrderWidget(
                    status: 0,
                  ),
                  _ListOrderWidget(
                    status: 2,
                  ),
                  _ListOrderWidget(
                    status: 4,
                  ),
                  _ListOrderWidget(
                    status: 6,
                  ),
                  _ListOrderWidget(
                    status: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListOrderWidget extends HookWidget {
  final int status;

  const _ListOrderWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<GetListOrderCubit>()
        ..onGetListData(
          param: injector<TokenParam>(),
          orderStatus: status,
          userId: injector<AuthenticationBloc>().state.user.userId!,
        ),
      child: BlocBuilder<GetListOrderCubit, GetListOrderState>(
        builder: (context, state) {
          if (state.orders.isNotEmpty) {
            return _ListOrder(
              listOrder: state.orders,
            );
          }

          if (state.orders.isEmpty &&
              state.status == GetListOrderStatus.loading) {
            return Center(
              child: CupertinoActivityIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          return Center(
            child: Text(
              'Đơn hàng trống',
              style: TextStyleApp.textStyle2.copyWith(
                color: AppColors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}



class _ListOrder extends HookWidget {
  final List<Order> listOrder;

  const _ListOrder({
    Key? key,
    required this.listOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ScrollController _mainScrollController = ScrollController();

    useEffect(() {
      _mainScrollController.addListener(
            () => useScrollControllerForLazyLoadingOrder(
          context,
          _mainScrollController,
        ),
      );
      return null;
    }, [
      _mainScrollController,
    ]);

    return ListView.builder(
      controller: _mainScrollController,
      itemCount: listOrder.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (_, index) {
        return ItemTabOrder(
          order: listOrder[index],
        );
        return Container();
      },
    );
  }
}

class ItemTabBar extends StatelessWidget {
  final String title;

  const ItemTabBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Text(
        title,
      ),
    );
  }
}

class ItemTabOrder extends StatelessWidget {
  final Order order;

  ItemTabOrder({
    required this.order,
  });

  checkNumber(data) {
    if (double.tryParse(data) != null) {
      return double.parse(data.toString());
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: List.generate(
            order.products!.length,
            (index) => buildListItem(
              order.products![index],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: AppColors.grey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                order.products!.length.toString() + " sản phẩm",
                style: TextStyleApp.textStyle2.copyWith(
                  color: AppColors.black,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 10,
              ),
              Text(
                "Thành tiền:",
                style: TextStyleApp.textStyle2.copyWith(
                  color: AppColors.black,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                convertPrice(double.parse(order.orderTotal ?? '0').round()),
                style: TextStyleApp.textStyle7.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: AppColors.grey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Địa chỉ giao hàng:",
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.textStyle7.copyWith(
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Họ - Tên:",
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    order.shippingName ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Số điện thoại:",
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    order.shippingPhone ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Địa chỉ:",
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    order.shippingAddress ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: AppColors.grey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phương thức thanh toán:",
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.textStyle7.copyWith(
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Text(
                order.paymentMethodName ?? '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyleApp.textStyle2.copyWith(
                  color: AppColors.black,
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: AppColors.grey,
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     vertical: 10,
        //     horizontal: 15,
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Phương thức vận chuyển:",
        //         overflow: TextOverflow.ellipsis,
        //         style: StyleTextApp.textStyle700(
        //           color: colorGrey13,
        //         ),
        //       ),
        //       SizedBox(height: 13,),
        //       Text(
        //         "Nhà cung cấp/Nhà sản xuất",overflow: TextOverflow.ellipsis,
        //         textAlign: TextAlign.left,
        //         style: StyleTextApp.textStyle400(
        //           color: colorGrey13,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // Divider(
        //   thickness: 1,
        //   color: colorGrey4,
        // ),
      ],
    );
  }

  Widget buildListItem(Product data) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.network(
              Environment.domain +
                  '/mediacenter/' +
                  (data.avatarPath ?? '') +
                  (data.avatarName ?? ''),
              height: 65,
              width: 65,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 65,
                  height: 65,
                  color: Colors.white,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      color: AppColors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleApp.textStyle7.copyWith(
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'x' + (data.productQty ?? '0'),
                  textAlign: TextAlign.right,
                  style: TextStyleApp.textStyle2.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      convertPrice(
                          double.parse(data.priceMarket ?? '0').round()),
                      style: TextStyleApp.textStyle2.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      convertPrice(double.parse(data.price ?? '0').round()),
                      style: TextStyleApp.textStyle7.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
