import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/shop/shop.dart';

import '../../../core/params/get_list_shop_param.dart';

abstract class GetListShopRepository {
  Future<DataState<List<Shop>>> getListShop(
    GetListShopParam params,
  );
}
