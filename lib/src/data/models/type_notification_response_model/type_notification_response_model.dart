import 'package:json_annotation/json_annotation.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';

import '../../../domain/entities/notification/type_notification.dart';

part 'type_notification_response_model.g.dart';

@JsonSerializable()
class TypeNotificationResponseModel {
  int? code;
  List<TypeNotification>? data;
  String? message;
  String? error;

  TypeNotificationResponseModel(
      {this.code, this.data, this.message, this.error});

  factory TypeNotificationResponseModel.fromJson(Map<String, dynamic> json) {

    return _$TypeNotificationResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TypeNotificationResponseModelToJson(this);
}
