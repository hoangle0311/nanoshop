import 'package:nanoshop/src/core/params/ward_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/entities/location/ward.dart';
import 'package:nanoshop/src/domain/repositories/location_repository/location_repository.dart';

class GetListWardUsecase
    extends UseCaseWithFuture<DataState<List<Ward>>, WardParam> {
  final LocationRepository _locationRepository;

  GetListWardUsecase(
    this._locationRepository,
  );

  @override
  Future<DataState<List<Ward>>> call(WardParam params) {
    return _locationRepository.getListWard(params);
  }
}
