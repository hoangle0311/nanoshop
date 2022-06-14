import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nanoshop/src/core/params/product_param.dart';
import 'package:nanoshop/src/data/data_source/local/product_local_service/product_local_service.dart';
import 'package:nanoshop/src/data/models/product_response_model/product_response_model.dart';
import 'package:nanoshop/src/domain/entities/flash_sale/flash_sale.dart';
import 'package:retrofit/dio.dart';

import '../../core/resource/data_state.dart';
import '../../domain/entities/product/product.dart';
import '../../domain/repositories/product_repository/product_repository.dart';
import '../data_source/remote/product_service/product_service.dart';
import '../models/user/user_login_response_model.dart';

class GetListProductRepositoryImpl extends ProductRepository {
  final ProductRemoteService _productRemoteService;
  final ProductLocalService _productLocalService;

  GetListProductRepositoryImpl(
    this._productRemoteService,
    this._productLocalService,
  );

  @override
  Future<DataState<ProductResponseModel>> getListProductRemote(
      ProductParam param) async {
    try {
      final HttpResponse<ProductResponseModel> response =
          await _productRemoteService.getListProduct(
        token: param.token,
        page: param.page,
        limit: param.limit,
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
  List<Product> getListFavouriteProductLocal() {
    return _productLocalService.getListFavouriteLocal();
  }

  @override
  Future<void> addFavouriteProductLocal(Product product) async {
    return await _productLocalService
        .addProductToListFavourite(product.copyWith(
      isLiked: 1,
    ));
  }

  @override
  Future<void> removeFavouriteProductLocal(Product product) async {
    return await _productLocalService.removeProductToListFavourite(product);
  }

  @override
  Future<DataState<FlashSale>> getListProductFlashSaleRemote() async {
    try {
      final HttpResponse<FlashSale> response =
          await _productRemoteService.getListProductFlashSale();

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
}
