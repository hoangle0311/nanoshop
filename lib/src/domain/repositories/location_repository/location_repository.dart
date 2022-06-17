import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/location_response_model/city_response_model.dart';
import 'package:nanoshop/src/data/models/location_response_model/district_response_model.dart';
import 'package:nanoshop/src/data/models/location_response_model/ward_response_model.dart';
import 'package:nanoshop/src/data/models/token_response_model/token_response_model.dart';

import '../../../core/params/token_param.dart';
import '../../../core/params/ward_param.dart';

abstract class LocationRepository {
  Future<DataState<CityResponseModel>> getListCity(TokenParam param);

  Future<DataState<DistrictResponseModel>> getListDistrict(
    DistrictParam param,
  );

  Future<DataState<WardResponseModel>> getListWard(
      WardParam param,
  );
}
