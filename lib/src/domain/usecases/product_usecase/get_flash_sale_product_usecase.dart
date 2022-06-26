import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../data/responses/flash_sale_response_model/flash_sale_response_model.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetListFlashSaleProductRemoteUsecase
    extends UseCaseWithFuture<DataState<FlashSaleResponseModel>, String> {
  final ProductRepository _productRepository;
  GetListFlashSaleProductRemoteUsecase(
    this._productRepository,
  );

  @override
  Future<DataState<FlashSaleResponseModel>> call(String params) {
    return _productRepository.getListProductFlashSaleRemote(params);
  }
}
