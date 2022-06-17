import 'package:nanoshop/src/core/params/get_list_shop_param.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/shop_response_model/shop_response_model.dart';

import '../../../core/resource/data_state.dart';
import '../../repositories/get_list_shop_repository/get_list_shop_repository.dart';

class GetListShopUsecase
    extends UseCaseWithFuture<DataState<ShopResponseModel>, GetListShopParam> {
  final GetListShopRepository _shopRepository;

  GetListShopUsecase(
    this._shopRepository,
  );

  @override
  Future<DataState<ShopResponseModel>> call(GetListShopParam params) {
    return _shopRepository.getListShop(params);
  }
}
