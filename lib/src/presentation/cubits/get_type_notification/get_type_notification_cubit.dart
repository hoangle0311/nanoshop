import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/notification/type_notification.dart';
import 'package:nanoshop/src/domain/usecases/notification_usecase/get_type_notification_usecase.dart';

import '../../../core/params/get_type_notification_param.dart';
import '../../../data/responses/type_notification_response_model/type_notification_response_model.dart';

part 'get_type_notification_state.dart';

class GetTypeNotificationCubit extends Cubit<GetTypeNotificationState> {
  final GetTypeNotificationUsecase _getTypeNotificationUsecase;

  GetTypeNotificationCubit(this._getTypeNotificationUsecase)
      : super(const GetTypeNotificationState());

  void onGetType(TokenParam tokenParam, String userId) async {
    emit(
      state.copyWith(
        status: GetTypeNotificationStatus.loading,
      ),
    );

    try {
      DataState<TypeNotificationResponseModel> dataState =
          await _getTypeNotificationUsecase.call(
        GetTypeNotificationParam(
          userId: userId,
          token: tokenParam.token,
        ),
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            listType: dataState.data!.data,
            status: GetTypeNotificationStatus.success,
          ),
        );
      }

      if (DataState is DataFailed) {
        emit(
          state.copyWith(
            status: GetTypeNotificationStatus.fail,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GetTypeNotificationStatus.fail,
        ),
      );
    }
  }
}
