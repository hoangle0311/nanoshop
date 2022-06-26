import 'dart:io';

import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/data/data_source/remote/location_service/location_service.dart';
import 'package:nanoshop/src/domain/repositories/location_repository/location_repository.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import '../../core/params/ward_param.dart';
import '../../core/utils/log/log.dart';
import '../responses/location_response_model/city_response_model.dart';
import '../responses/location_response_model/district_response_model.dart';
import '../responses/location_response_model/ward_response_model.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationService _locationService;

  LocationRepositoryImpl(
    this._locationService,
  );

  @override
  Future<DataState<CityResponseModel>> getListCity(TokenParam param) async {
    try {
      final HttpResponse<CityResponseModel> response =
          await _locationService.getCity(
        token: param.token,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<DistrictResponseModel>> getListDistrict(
      DistrictParam param) async {
    try {
      final HttpResponse<DistrictResponseModel> response =
          await _locationService.getDistrict(
        token: param.token,
        body: {
          "province_id": param.provinceId,
        },
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      Log.i(e.toString());

      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<WardResponseModel>> getListWard(WardParam param) async {
    try {
      final HttpResponse<WardResponseModel> response =
          await _locationService.getWard(
        token: param.token,
        body: {
          "district_id": param.districtId,
        },
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.response.statusMessage,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      Log.i(e.toString());

      return DataFailed(
        error: e,
      );
    }
  }
}
