import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';

import '../../entities/product/product.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetListFavouriteProductLocalUsecase extends UseCaseWithFuture<List<Product>, void> {
  final ProductRepository _productRepository;
  GetListFavouriteProductLocalUsecase(
    this._productRepository,
  );

  @override
  Future<List<Product>> call(void params) async {
    return _productRepository.getListFavouriteProductLocal();
  }
}
