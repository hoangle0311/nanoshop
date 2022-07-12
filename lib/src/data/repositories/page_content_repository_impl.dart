import 'dart:io';

import 'package:nanoshop/src/data/data_source/remote/page_content_service/page_content_service.dart';
import 'package:nanoshop/src/data/responses/page_content_response/page_content_response.dart';
import 'package:nanoshop/src/domain/repositories/page_content_repository/page_content_repository.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../core/params/page_content_param.dart';
import '../../domain/entities/page_content/page_content_model.dart';

class PageContentRepositoryImpl extends PageContentRepository {
  final PageContentService _pageContentService;

  PageContentRepositoryImpl(
      this._pageContentService,
      );

  @override
  Future<DataState<PageContentModel>> getPageContent(
      PageContentParam param) async {
    try {
      final HttpResponse<PageContentResponse> response =
      await _pageContentService.getPageContent(
        body: param.toJson(),
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
