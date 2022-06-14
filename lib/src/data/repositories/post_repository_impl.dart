import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nanoshop/src/core/params/post_param.dart';
import 'package:nanoshop/src/data/data_source/remote/post_service/post_remote_service.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';
import 'package:nanoshop/src/domain/repositories/post_repository/post_repository.dart';
import 'package:retrofit/dio.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';

import '../models/post_response_model/post_response_model.dart';

class PostRepositoryImpl extends PostRepository {
  final PostRemoteService _postService;

  PostRepositoryImpl(
    this._postService,
  );

  @override
  Future<DataState<PostResponseModel>> getListPostRemote(
      PostParam param) async {
    try {
      final HttpResponse<PostResponseModel> response = await _postService.getListPost(
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
}
