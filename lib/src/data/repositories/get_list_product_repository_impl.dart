import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nanoshop/src/core/params/add_comment_param.dart';
import 'package:nanoshop/src/core/params/detail_product_param.dart';
import 'package:nanoshop/src/core/params/get_list_comment_param.dart';
import 'package:nanoshop/src/core/params/list_flashsale_with_list_product_param.dart';
import 'package:nanoshop/src/core/params/product_param.dart';
import 'package:nanoshop/src/core/params/related_product_param.dart';
import 'package:nanoshop/src/core/params/search_product_param.dart';
import 'package:nanoshop/src/data/data_source/local/product_local_service/product_local_service.dart';
import 'package:retrofit/dio.dart';

import '../../core/resource/data_state.dart';
import '../../domain/entities/flash_sale/flash_sale.dart';
import '../../domain/entities/product/product.dart';
import '../../domain/repositories/product_repository/product_repository.dart';
import '../data_source/remote/product_service/product_service.dart';
import '../responses/add_comment_response/add_comment_response_model.dart';
import '../responses/comment_response_model/comment_response_model.dart';
import '../responses/flash_sale_response_model/flash_sale_response_model.dart';
import '../responses/flash_sale_with_list_product_response_model/flash_sale_with_list_product_response_model.dart';
import '../responses/manufacturer_response_model/manufacturer_response_model.dart';
import '../responses/product_response_model/detail_product_response_model.dart';
import '../responses/product_response_model/product_response_model.dart';

class GetListProductRepositoryImpl extends ProductRepository {
  final ProductRemoteService _productRemoteService;
  final ProductLocalService _productLocalService;

  GetListProductRepositoryImpl(
    this._productRemoteService,
    this._productLocalService,
  );

  @override
  Future<DataState<List<Product>>> getListProductRemote(
      ProductParam param) async {
    try {
      final HttpResponse<ProductResponseModel> response =
          await _productRemoteService.getListProduct(
        token: param.token,
        body: param.toJson(),
      );

      if (response.data.code == 1) {
        return DataSuccess(data: response.data.data!.data!);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.data.message,
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
  Future<DataState<List<FlashSale>>> getListFlashSaleRemote(
      String params) async {
    try {
      final HttpResponse<FlashSaleResponseModel> response =
          await _productRemoteService.getListFlashSale(
        token: params,
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

  @override
  Future<DataState<DetailProductResponseModel>> getDetailProductRemote(
      DetailProductParam param) async {
    try {
      final HttpResponse<DetailProductResponseModel> response =
          await _productRemoteService.getDetailProduct(
        token: param.token,
        id: param.id,
        type: param.type,
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
  Future<DataState<AddCommentResponseModel>> addCommentRemote(
      AddCommentParam params) async {
    try {
      final HttpResponse<AddCommentResponseModel> response =
          await _productRemoteService.addComment(
        token: params.token,
        body: {
          "user_id": params.userId,
          "object_id": params.productId,
          "count_rate": params.countRate,
          "Comment": {
            // "name": params.name,
            "type": int.parse(params.type),
            "comment": params.content,
            // "email_phone": params.phone,
          },
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
      return DataFailed(
        error: e,
      );
    }
  }

  @override
  Future<DataState<CommentResponseModel>> getListCommentRemote(
      GetListCommentParam params) async {
    try {
      final HttpResponse<CommentResponseModel> response =
          await _productRemoteService.getListComment(
        token: params.token,
        body: params.toJson(),
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
  Future<DataState<List<Product>>> getListRelatedProductRemote(
      RelatedProductParam param) async {
    try {
      final HttpResponse<ProductResponseModel> response =
          await _productRemoteService.relatedListProduct(
        token: param.token,
        body: param.toJson(),
      );

      if (response.data.code == 1) {
        return DataSuccess(data: response.data.data!.data!);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.data.message,
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
  Future<DataState<List<Product>>> getSearchListProductRemote(
    SearchProductParam param,
  ) async {
    try {
      final HttpResponse<ProductResponseModel> response =
          await _productRemoteService.relatedListProduct(
        token: param.token,
        body: param.toJson(),
      );

      if (response.data.code == 1) {
        return DataSuccess(data: response.data.data!.data!);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.data.message,
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
  Future<DataState<ManufacturerResponseModel>> getListManufacturer(
      String token) async {
    try {
      final HttpResponse<ManufacturerResponseModel> response =
          await _productRemoteService.getListManufacturer(
        token: token,
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.data.message,
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
  Future<DataState<List<Product>>> getListFlashSaleWithListProductRemote(
      ListFlashSaleWithListProductParam params) async {
    try {
      final HttpResponse<FlashSaleWithListProductResponseModel> response =
          await _productRemoteService.getFlashSaleWithListProduct(
        token: params.token,
        body: params.toJson(),
      );

      if (response.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: response.data.data!.data!);
      }

      return DataFailed(
        error: DioError(
          requestOptions: response.response.requestOptions,
          error: response.data.message,
          type: DioErrorType.response,
        ),
      );
    } on DioError catch (e) {
      print(e);
      return DataFailed(
        error: e,
      );
    }
  }
}
