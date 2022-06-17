import 'package:nanoshop/src/core/params/add_comment_param.dart';
import 'package:nanoshop/src/core/params/search_product_param.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/add_comment_response/add_comment_response_model.dart';
import 'package:nanoshop/src/data/models/product_response_model/product_response_model.dart';

import '../../../core/resource/data_state.dart';
import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class SearchListProductUsecase extends UseCaseWithFuture<
    DataState<ProductResponseModel>, SearchProductParam> {
  final ProductRepository _productRepository;

  SearchListProductUsecase(
      this._productRepository,
      );

  @override
  Future<DataState<ProductResponseModel>> call(SearchProductParam params) {
    return _productRepository.getSearchListProductRemote(params);
  }
}
