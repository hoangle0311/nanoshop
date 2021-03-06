import 'package:flutter/material.dart';
import 'package:nanoshop/src/core/page_route/custom_page_route.dart';
import 'package:nanoshop/src/data/models/cart/cart.dart';
import 'package:nanoshop/src/domain/entities/payment/payment.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/domain/entities/shop/shop.dart';
import 'package:nanoshop/src/domain/entities/transport/transport.dart';
import 'package:nanoshop/src/presentation/ui/add_address/sc_add_address.dart';
import 'package:nanoshop/src/presentation/ui/change_password/sc_change_password.dart';
import 'package:nanoshop/src/presentation/ui/choose_payment/sc_choose_payment.dart';
import 'package:nanoshop/src/presentation/ui/choose_transport/sc_choose_transport.dart';
import 'package:nanoshop/src/presentation/ui/detail_post/sc_detail_post.dart';
import 'package:nanoshop/src/presentation/ui/filter_product/sc_filter_product.dart';
import 'package:nanoshop/src/presentation/ui/home/sc_home.dart';
import 'package:nanoshop/src/presentation/ui/list_order/sc_list_order.dart';
import 'package:nanoshop/src/presentation/ui/list_product/sc_list_product.dart';
import 'package:nanoshop/src/presentation/ui/list_shop/sc_list_shop.dart';
import 'package:nanoshop/src/presentation/ui/login/sc_login.dart';
import 'package:nanoshop/src/presentation/ui/menu/sc_menu.dart';
import 'package:nanoshop/src/presentation/ui/notification/sc_notification.dart';
import 'package:nanoshop/src/presentation/ui/payment_shopping_cart/sc_payment_shopping_cart.dart';
import 'package:nanoshop/src/presentation/ui/search_product/sc_search_product.dart';
import 'package:nanoshop/src/presentation/ui/shopping_cart/sc_shopping_cart.dart';
import 'package:nanoshop/src/presentation/ui/sign_up/sc_sign_up.dart';
import 'package:nanoshop/src/presentation/ui/update_information/sc_update_information.dart';

import '../../../presentation/ui/detail_shop/sc_detail_shop.dart';
import '../../../presentation/ui/list_category/sc_list_category.dart';
import '../../../presentation/ui/send_comment/sc_send_comment.dart';

part 'app_router_endpoint.dart';

class AppRouters {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return _materialRoute(const BreakingNewsView());
      case AppRouterEndPoint.HOME:
        return _materialRoute(
          const ScHome(),
          direction: AxisDirection.up,
        );
      case AppRouterEndPoint.LISTORDER:
        return _materialRoute(
          const ScListOrder(),
        );
      case AppRouterEndPoint.LOGIN:
        return _materialRoute(
          const ScLogin(),
          direction: AxisDirection.up,
        );
      case AppRouterEndPoint.LISTPRODUCT:
        return _materialRoute(
          ScListProduct(
            argument: settings.arguments as ScListProductArgument,
          ),
        );
      case AppRouterEndPoint.FilterProduct:
        return _materialRoute(
          const ScFilterProduct(),
        );
      case AppRouterEndPoint.NOTIFICATION:
        return _materialRoute(
          const ScNotification(),
        );
      case AppRouterEndPoint.UPDATEINFORMATION:
        return _materialRoute(
          const ScUpdateInformation(),
        );
      case AppRouterEndPoint.MENU:
        return _materialRoute(
          const ScMenu(),
        );
      case AppRouterEndPoint.SIGNUP:
        return _materialRoute(
          const ScSignUp(),
        );
      case AppRouterEndPoint.SHOPPINGCART:
        return _materialRoute(
          const ScShoppingCart(),
        );
      case AppRouterEndPoint.LISTSHOP:
        return _materialRoute(
          const ScListShop(),
        );
      case AppRouterEndPoint.CHANGEPASSWORD:
        return _materialRoute(
          const ScChangePassword(),
        );
      case AppRouterEndPoint.SEARCHPRODUCT:
        return _materialRoute(
          const ScSearchProduct(),
        );
      case AppRouterEndPoint.LISTCATEGORY:
        return _materialRoute(
          const ScListCategory(),
        );
      case AppRouterEndPoint.DETAILSHOP:
        return _materialRoute(
          ScDetailShop(
            argument: settings.arguments as Shop,
          ),
        );
      case AppRouterEndPoint.PAYMENTSHOPPINGCART:
        return _materialRoute(
          ScPaymentShoppingCart(
            listCart: settings.arguments as List<Cart>,
          ),
        );
      case AppRouterEndPoint.DETAILPOST:
        return _materialRoute(
          ScDetailPost(initialPage: settings.arguments as int),
        );
      case AppRouterEndPoint.ADDADDRESS:
        return _materialRoute(
          ScAddAddress(),
        );
      case AppRouterEndPoint.CHOOSEPAYMENT:
        return _materialRoute(
          ScChoosePayment(payment: settings.arguments as Payment),
        );
      case AppRouterEndPoint.CHOOSETRANSPORT:
        return _materialRoute(
          ScChooseTransport(
            transport: settings.arguments as Transport,
          ),
        );
      case AppRouterEndPoint.SENDCOMMENT:
        return _materialRoute(
          ScSendComment(
            product: settings.arguments as Product,
          ),
        );
      default:
        return _materialRoute(
          Scaffold(
            appBar: AppBar(
              title: Text('M???c ?????nh'),
            ),
          ),
        );
    }
  }

  static Route<dynamic> _materialRoute(
    Widget view, {
    AxisDirection? direction,
  }) {
    return CustomPageRoute(
      child: view,
      direction: direction,
    );
  }
}
