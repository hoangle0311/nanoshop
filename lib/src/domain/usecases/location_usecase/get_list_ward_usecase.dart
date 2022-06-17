import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/params/ward_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/data/models/location_response_model/district_response_model.dart';
import 'package:nanoshop/src/data/models/location_response_model/ward_response_model.dart';
import 'package:nanoshop/src/domain/repositories/location_repository/location_repository.dart';

import '../../../core/utils/log/log.dart';

class GetListWardUsecase
    extends UseCaseWithFuture<DataState<WardResponseModel>, WardParam> {
  final LocationRepository _locationRepository;

  GetListWardUsecase(
    this._locationRepository,
  );

  @override
  Future<DataState<WardResponseModel>> call(WardParam params) {
    return _locationRepository.getListWard(params);
  }
}
