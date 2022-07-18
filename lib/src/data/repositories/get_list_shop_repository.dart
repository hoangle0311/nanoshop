import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nanoshop/src/data/models/shop/shop_model.dart';
import 'package:retrofit/dio.dart';

import 'package:nanoshop/src/core/params/get_list_shop_param.dart';
import 'package:nanoshop/src/domain/repositories/get_list_shop_repository/get_list_shop_repository.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';

import '../data_source/remote/shop_service/shop_service.dart';
import '../responses/shop_response_model/shop_response_model.dart';

class GetListShopRepositoryImpl extends GetListShopRepository {
  final ShopService _shopService;

  GetListShopRepositoryImpl(
      this._shopService,
      );

  @override
  Future<DataState<List<ShopModel>>> getListShop(
      GetListShopParam params) async {
    try {
      final HttpResponse<ShopResponseModel> response =
      await _shopService.getListShop(
        body: params.toJson(),
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data.data!);
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
