import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/location/city.dart';
import 'package:nanoshop/src/domain/repositories/location_repository/location_repository.dart';

class GetListCityUsecase
    extends UseCaseWithFuture<DataState<List<City>>, void> {
  final LocationRepository _locationRepository;

  GetListCityUsecase(
    this._locationRepository,
  );

  @override
  Future<DataState<List<City>>> call(void params) {
    return _locationRepository.getListCity();
  }
}
