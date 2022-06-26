import 'package:nanoshop/src/core/params/product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../data/responses/product_response_model/product_response_model.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetListProductRemoteUsecase
    extends UseCaseWithFuture<DataState<ProductResponseModel>, ProductParam> {
  final ProductRepository _productRepository;
  GetListProductRemoteUsecase(
    this._productRepository,
  );

  @override
  Future<DataState<ProductResponseModel>> call(ProductParam params) {
    return _productRepository.getListProductRemote(params);
  }
}
