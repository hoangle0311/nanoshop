import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class AddFavouriteProductLocalUsecase extends UseCaseWithFuture<void, Product> {
  final ProductRepository _productRepository;
  AddFavouriteProductLocalUsecase(
    this._productRepository,
  );

  @override
  Future<void> call(Product params) {
    return _productRepository.addFavouriteProductLocal(params);
  }
}
