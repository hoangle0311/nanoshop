import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/flash_sale/flash_sale.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';

import '../../../data/responses/flash_sale_response_model/flash_sale_response_model.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetListFlashSaleProductRemoteUsecase
    extends UseCaseWithFuture<DataState<List<FlashSale>>, String> {
  final ProductRepository _productRepository;
  GetListFlashSaleProductRemoteUsecase(
    this._productRepository,
  );

  @override
  Future<DataState<List<FlashSale>>> call(String params) {
    return _productRepository.getListFlashSaleRemote(params);
  }
}
