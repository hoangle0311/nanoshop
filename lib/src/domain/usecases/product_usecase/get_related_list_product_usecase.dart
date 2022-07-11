import 'package:nanoshop/src/core/params/related_product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../../data/responses/product_response_model/product_response_model.dart';
import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetRelatedListProductUsecase
    extends UseCaseWithFuture<DataState<List<Product>>, RelatedProductParam> {
  final ProductRepository _productRepository;
  GetRelatedListProductUsecase(
      this._productRepository,
      );

  @override
  Future<DataState<List<Product>>> call(RelatedProductParam params) {
    return _productRepository.getListRelatedProductRemote(params);
  }
}
