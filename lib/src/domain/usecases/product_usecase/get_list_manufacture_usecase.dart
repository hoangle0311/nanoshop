import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import '../../../data/responses/manufacturer_response_model/manufacturer_response_model.dart';
import '../../repositories/product_repository/product_repository.dart';

class GetListManufacturerUsecase extends UseCaseWithFuture<DataState<ManufacturerResponseModel>, void> {
  final ProductRepository _productRepository;
  GetListManufacturerUsecase(
      this._productRepository,
      );

  @override
  Future<DataState<ManufacturerResponseModel>> call(void params) async {
    return _productRepository.getListManufacturer();
  }
}
