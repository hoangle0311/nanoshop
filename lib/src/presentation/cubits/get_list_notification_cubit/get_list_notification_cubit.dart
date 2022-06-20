import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/get_list_notification_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/notification_response_model/notification_response_model.dart';
import 'package:nanoshop/src/domain/entities/notification/notification.dart';
import 'package:nanoshop/src/domain/usecases/notification_usecase/get_list_notification_usecase.dart';

part 'get_list_notification_state.dart';

class GetListNotificationCubit extends Cubit<GetListNotificationState> {
  final GetListNotificationUsecase _getListNotificationUsecase;

  GetListNotificationCubit(this._getListNotificationUsecase)
      : super(const GetListNotificationState());

  static const _postPerPage = 10;

  onLoadMore() async {
    emit(
      state.copyWith(
        status: GetListNotificationStatus.loading,
      ),
    );

    GetListNotificationParam param = GetListNotificationParam(
      limit: _postPerPage,
      type: state.param!.type,
      page: state.param!.page + 1,
      userId: state.param!.userId,
      token: state.param!.token,
    );

    try {
      DataState<NotificationResponseModel> dataState =
          await _getListNotificationUsecase.call(param);

      if (dataState is DataSuccess) {
        List<Notifications> listNotification = [];

        listNotification.addAll(dataState.data!.data!);

        emit(
          state.copyWith(
            status: GetListNotificationStatus.success,
            param: param,
            notifications: state.notifications..addAll(listNotification),
            hasMore: listNotification.length >= _postPerPage,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GetListNotificationStatus.fail,
          param: param,
          hasMore: false,
        ),
      );
    }
  }

  onGetNotification(
    TokenParam tokenParam,
    String userId,
    int type,
  ) async {
    emit(
      state.copyWith(status: GetListNotificationStatus.loading),
    );

    GetListNotificationParam param = GetListNotificationParam(
      limit: _postPerPage,
      type: type.toString(),
      page: 1,
      userId: userId,
      token: tokenParam.token,
    );

    try {
      DataState<NotificationResponseModel> dataState =
          await _getListNotificationUsecase.call(param);

      if (dataState is DataSuccess) {
        List<Notifications> listNotification = [];

        listNotification.addAll(dataState.data!.data!);

        emit(
          state.copyWith(
            status: GetListNotificationStatus.success,
            param: param,
            notifications: listNotification,
            hasMore: listNotification.length >= _postPerPage,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GetListNotificationStatus.fail,
          param: param,
        ),
      );
    }
  }
}
