import 'dart:io';

import 'package:nanoshop/src/data/models/post/post_model.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/params/list_post_param.dart';
import 'package:nanoshop/src/core/params/post_param.dart';
import 'package:nanoshop/src/data/data_source/remote/post_service/post_remote_service.dart';
import 'package:nanoshop/src/domain/repositories/post_repository/post_repository.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';

import '../responses/list_post_response_model/list_post_response_model.dart';
import '../responses/post_response_model/post_response_model.dart';


class PostRepositoryImpl extends PostRepository {
  final PostRemoteService _postService;

  PostRepositoryImpl(
    this._postService,
  );

  @override
  Future<DataState<List<PostModel>>> getListPostRemote(
      PostParam param) async {
    try {
      final HttpResponse<PostResponseModel> response = await _postService.getListPost(
        page: param.page,
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

  @override
  Future<DataState<PostModel>> getDetailPostRemote(DetailPostParam param) async {
    try {
      final HttpResponse<DetailPostResponseModel> response = await _postService.detailPost(
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
