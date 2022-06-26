import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../responses/notification_response_model/notification_response_model.dart';
import '../../../responses/type_notification_response_model/type_notification_response_model.dart';

part 'notification_service.g.dart';

@RestApi()
abstract class NotificationService {
  factory NotificationService(Dio dio, {String baseUrl}) = _NotificationService;

  @POST(ApiPath.getTypeNotification)
  Future<HttpResponse<TypeNotificationResponseModel>> getType({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiPath.getNotification)
  Future<HttpResponse<NotificationResponseModel>> getListNotification({
    @Header("token") required String token,
    @Body() required Map<String, dynamic> body,
  });
}
