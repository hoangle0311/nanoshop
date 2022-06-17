import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/location_response_model/district_response_model.dart';
import 'package:nanoshop/src/domain/repositories/location_repository/location_repository.dart';

import '../../../core/utils/log/log.dart';

class GetListDistrictUsecase
    extends UseCaseWithFuture<DataState<DistrictResponseModel>, DistrictParam> {
  final LocationRepository _locationRepository;

  GetListDistrictUsecase(
    this._locationRepository,
  );

  @override
  Future<DataState<DistrictResponseModel>> call(DistrictParam params) {
    return _locationRepository.getListDistrict(params);
  }
}
