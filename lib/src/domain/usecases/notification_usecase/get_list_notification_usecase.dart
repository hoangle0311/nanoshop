import 'package:nanoshop/src/core/params/get_list_notification_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/notification_repository/notification_repository.dart';

import '../../../data/responses/notification_response_model/notification_response_model.dart';


class GetListNotificationUsecase
    extends UseCaseWithFuture<DataState<NotificationResponseModel>, GetListNotificationParam> {
  final NotificationRepository _notificationRepository;

  GetListNotificationUsecase(
      this._notificationRepository,
      );

  @override
  Future<DataState<NotificationResponseModel>> call(GetListNotificationParam params) {
    return _notificationRepository.getListNotification(params);
  }
}
