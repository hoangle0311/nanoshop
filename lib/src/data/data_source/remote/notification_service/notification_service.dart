import 'package:nanoshop/src/core/constant/api/api_path.dart';
import 'package:nanoshop/src/data/models/location_response_model/city_response_model.dart';
import 'package:nanoshop/src/data/models/location_response_model/district_response_model.dart';
import 'package:nanoshop/src/data/models/location_response_model/ward_response_model.dart';
import 'package:nanoshop/src/data/models/notification_response_model/notification_response_model.dart';
import 'package:nanoshop/src/data/models/type_notification_response_model/type_notification_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

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
