import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../core/params/get_list_shop_param.dart';
import '../../../data/models/shop_response_model/shop_response_model.dart';

abstract class GetListShopRepository {
  Future<DataState<ShopResponseModel>> getListShop(
    GetListShopParam params,
  );
}
