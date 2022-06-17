import 'package:nanoshop/src/core/params/detail_product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/product_response_model/detail_product_response_model.dart';

import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetDetailProductRemoteUsecase extends UseCaseWithFuture<
    DataState<DetailProductResponseModel>, DetailProductParam> {
  final ProductRepository _productRepository;

  GetDetailProductRemoteUsecase(
    this._productRepository,
  );

  @override
  Future<DataState<DetailProductResponseModel>> call(
      DetailProductParam params) {
    return _productRepository.getDetailProductRemote(params);
  }
}
