import 'package:nanoshop/src/core/params/search_product_param.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../core/resource/data_state.dart';
import '../../../data/responses/product_response_model/product_response_model.dart';
import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class SearchListProductUsecase extends UseCaseWithFuture<
    DataState<List<Product>>, SearchProductParam> {
  final ProductRepository _productRepository;

  SearchListProductUsecase(
      this._productRepository,
      );

  @override
  Future<DataState<List<Product>>> call(SearchProductParam params) {
    return _productRepository.getSearchListProductRemote(params);
  }
}
