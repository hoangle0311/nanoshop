import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/token_response_model/token_response_model.dart';

import '../../../core/params/get_list_notification_param.dart';
import '../../../core/params/get_type_notification_param.dart';
import '../../../core/params/token_param.dart';
import '../../../data/models/notification_response_model/notification_response_model.dart';
import '../../../data/models/type_notification_response_model/type_notification_response_model.dart';

abstract class NotificationRepository {
  Future<DataState<TypeNotificationResponseModel>> getTypeNotification(GetTypeNotificationParam param);
  Future<DataState<NotificationResponseModel>> getListNotification(GetListNotificationParam param);
}
