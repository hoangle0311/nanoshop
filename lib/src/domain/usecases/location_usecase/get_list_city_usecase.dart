import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/location_repository/location_repository.dart';

import '../../../data/responses/location_response_model/city_response_model.dart';

class GetListCityUsecase
    extends UseCaseWithFuture<DataState<CityResponseModel>, TokenParam> {
  final LocationRepository _locationRepository;

  GetListCityUsecase(
    this._locationRepository,
  );

  @override
  Future<DataState<CityResponseModel>> call(TokenParam params) {
    return _locationRepository.getListCity(params);
  }
}
