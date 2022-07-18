import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/location/city.dart';
import 'package:nanoshop/src/domain/entities/location/district.dart';
import 'package:nanoshop/src/domain/entities/location/ward.dart';

import '../../../core/params/ward_param.dart';

abstract class LocationRepository {
  Future<DataState<List<City>>> getListCity();

  Future<DataState<List<District>>> getListDistrict(
    DistrictParam param,
  );

  Future<DataState<List<Ward>>> getListWard(
      WardParam param,
  );
}
