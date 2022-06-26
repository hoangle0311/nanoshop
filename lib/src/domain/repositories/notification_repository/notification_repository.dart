import 'package:nanoshop/src/core/resource/data_state.dart';

import '../../../core/params/get_list_notification_param.dart';
import '../../../core/params/get_type_notification_param.dart';
import '../../../core/params/token_param.dart';
import '../../../data/responses/notification_response_model/notification_response_model.dart';
import '../../../data/responses/type_notification_response_model/type_notification_response_model.dart';

abstract class NotificationRepository {
  Future<DataState<TypeNotificationResponseModel>> getTypeNotification(GetTypeNotificationParam param);
  Future<DataState<NotificationResponseModel>> getListNotification(GetListNotificationParam param);
}
