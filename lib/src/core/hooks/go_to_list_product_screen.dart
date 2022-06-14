import 'package:flutter/cupertino.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';

import '../../presentation/ui/list_product/sc_list_product.dart';

goToListProductScreen({
  required BuildContext context,
  required String title,
}) {
  Navigator.of(context).pushNamed(
    AppRouterEndPoint.LISTPRODUCT,
    arguments: ScListProductArgument(
      title: title,
    ),
  );
}
