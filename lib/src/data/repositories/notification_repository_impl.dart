import 'dart:io';

import 'package:nanoshop/src/core/params/get_list_notification_param.dart';
import 'package:nanoshop/src/core/params/get_type_notification_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/data/data_source/remote/notification_service/notification_service.dart';
import 'package:nanoshop/src/data/models/notification_response_model/notification_response_model.dart';
import 'package:nanoshop/src/data/models/type_notification_response_model/type_notification_response_model.dart';
import 'package:nanoshop/src/domain/repositories/notification_repository/notification_repository.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/data_source/remote/get_token_service/get_token_service.dart';
import 'package:nanoshop/src/domain/entities/token/token.dart';
import 'package:nanoshop/src/domain/repositories/get_token_repository/get_token_repository.dart';

import '../../core/utils/log/log.dart';
import '../models/token_response_model/token_response_model.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationService _notificationService;

  NotificationRepositoryImpl(
    this._notificationService,
  );

  @override
  Future<DataState<TypeNotificationResponseModel>> getTypeNotification(
      GetTypeNotificationParam param) async {
    try {
      final HttpResponse<TypeNotificationResponseModel> response =
          await _notificationService.getType(
        token: param.token,
        body: param.toJson(),
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
  Future<DataState<NotificationResponseModel>> getListNotification(
      GetListNotificationParam param) async {
    Log.i(param.toJson().toString());
    try {
      final HttpResponse<NotificationResponseModel> response =
      await _notificationService.getListNotification(
        token: param.token,
        body: param.toJson(),
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
      Log.e(e.toString());
      return DataFailed(
        error: e,
      );
    }
  }
}
