import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class RemoveFavouriteProductLocalUsecase extends UseCaseWithFuture<void, Product> {
  final ProductRepository _productRepository;
  RemoveFavouriteProductLocalUsecase(
    this._productRepository,
  );

  @override
  Future<void> call(Product params) {
    return _productRepository.removeFavouriteProductLocal(params);
  }
}
