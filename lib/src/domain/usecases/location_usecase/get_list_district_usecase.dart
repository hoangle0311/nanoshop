import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/location/district.dart';
import 'package:nanoshop/src/domain/repositories/location_repository/location_repository.dart';

class GetListDistrictUsecase
    extends UseCaseWithFuture<DataState<List<District>>, DistrictParam> {
  final LocationRepository _locationRepository;

  GetListDistrictUsecase(
    this._locationRepository,
  );

  @override
  Future<DataState<List<District>>> call(DistrictParam params) {
    return _locationRepository.getListDistrict(params);
  }
}
