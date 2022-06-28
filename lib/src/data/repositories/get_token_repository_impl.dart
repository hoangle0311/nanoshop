import 'dart:io';

import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/data_source/remote/get_token_service/get_token_service.dart';
import 'package:nanoshop/src/domain/repositories/get_token_repository/get_token_repository.dart';

import '../responses/token_response_model/token_response_model.dart';


class GetTokenRepositoryImpl extends GetTokenRepository {
  final GetTokenService _getTokenService;

  GetTokenRepositoryImpl(
    this._getTokenService,
  );

  @override
  Future<DataState<TokenResponseModel>> getToken(TokenParam param) async {
    try {
      final HttpResponse<TokenResponseModel> response =
          await _getTokenService.getToken(
        string: param.string,
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
}
