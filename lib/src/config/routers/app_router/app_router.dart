import 'package:flutter/material.dart';
import 'package:nanoshop/src/core/page_route/custom_page_route.dart';
import 'package:nanoshop/src/presentation/ui/list_product/sc_list_product.dart';
import 'package:nanoshop/src/presentation/ui/login/sc_login.dart';
import 'package:nanoshop/src/presentation/ui/menu/sc_menu.dart';
import 'package:nanoshop/src/presentation/ui/sign_up/sc_sign_up.dart';

part 'app_router_endpoint.dart';

class AppRouters {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return _materialRoute(const BreakingNewsView());
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
      case AppRouterEndPoint.MENU:
        return _materialRoute(
          ScMenu(),
        );
      case AppRouterEndPoint.SIGNUP:
        return _materialRoute(
          ScSignUp(),
        );
      default:
        return _materialRoute(
          Scaffold(
            appBar: AppBar(
              title: Text('Mặc định'),
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
