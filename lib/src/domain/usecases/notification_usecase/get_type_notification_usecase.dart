import 'package:nanoshop/src/core/params/get_type_notification_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/usecases/usecase_with_future.dart';
import 'package:nanoshop/src/domain/repositories/notification_repository/notification_repository.dart';

import '../../../data/responses/type_notification_response_model/type_notification_response_model.dart';


class GetTypeNotificationUsecase
    extends UseCaseWithFuture<DataState<TypeNotificationResponseModel>, GetTypeNotificationParam> {
  final NotificationRepository _notificationRepository;

  GetTypeNotificationUsecase(
      this._notificationRepository,
      );

  @override
  Future<DataState<TypeNotificationResponseModel>> call(GetTypeNotificationParam params) {
    return _notificationRepository.getTypeNotification(params);
  }
}
