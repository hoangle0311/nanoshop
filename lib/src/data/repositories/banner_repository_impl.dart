import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nanoshop/src/core/params/banner_param.dart';
import 'package:nanoshop/src/data/models/banner/banner_model.dart';
import 'package:retrofit/dio.dart';

import 'package:nanoshop/src/data/data_source/remote/banner_service/banner_service.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/repositories/banner_repository/banner_repository.dart';

import '../responses/banner_response_model.dart/banner_response_model.dart';


class BannerRepositoryImpl extends BannerRepository {
  final BannerService _bannerService;

  BannerRepositoryImpl(
    this._bannerService,
  );

  @override
  Future<DataState<List<BannerModel>>> getListBanner(
    BannerParam param,
  ) async {
    try {
      final HttpResponse<BannerResponseModel> response =
          await _bannerService.getBanner(
        groupId: param.groupId,
        limit: param.limit,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data.data!.data!);
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
}
