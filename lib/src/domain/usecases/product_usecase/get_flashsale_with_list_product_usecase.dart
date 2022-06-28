import 'package:nanoshop/src/core/params/list_flashsale_with_list_product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetFlashSaleWithListProductRemoteUsecase
    extends UseCaseWithFuture<DataState<List<Product>>, ListFlashSaleWithListProductParam> {
  final ProductRepository _productRepository;
  GetFlashSaleWithListProductRemoteUsecase(
      this._productRepository,
      );

  @override
  Future<DataState<List<Product>>> call(ListFlashSaleWithListProductParam params) {
    return _productRepository.getListFlashSaleWithListProductRemote(params);
  }
}
