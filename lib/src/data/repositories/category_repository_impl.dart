import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/data/models/category_response_model/category_response_model.dart';
import 'package:retrofit/dio.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../domain/entities/category/category.dart';
import '../../domain/repositories/category_repository/category_repository.dart';
import '../data_source/remote/remote_service.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepositoryImpl(
    this._categoryService,
  );

  @override
  Future<DataState<CategoryResponseModel>> getListCategory(
      CategoryParam params) async {
    try {
      final HttpResponse<CategoryResponseModel> response =
          await _categoryService.getListCategory(
        type: params.type,
        token: params.token,
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
}
