import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../core/params/token_param.dart';
import '../../../core/params/ward_param.dart';
import '../../../data/responses/location_response_model/city_response_model.dart';
import '../../../data/responses/location_response_model/district_response_model.dart';
import '../../../data/responses/location_response_model/ward_response_model.dart';

abstract class LocationRepository {
  Future<DataState<CityResponseModel>> getListCity();

  Future<DataState<DistrictResponseModel>> getListDistrict(
    DistrictParam param,
  );

  Future<DataState<WardResponseModel>> getListWard(
      WardParam param,
  );
}
