import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/domain/entities/notification/notification.dart';

part 'notification_response_model.g.dart';

@JsonSerializable()
class NotificationResponseModel {
  int? code;
  List<Notifications>? data;
  String? message;
  String? error;

  NotificationResponseModel({this.code, this.data, this.message, this.error});

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    Log.i(json.toString());
    return _$NotificationResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationResponseModelToJson(this);
}
