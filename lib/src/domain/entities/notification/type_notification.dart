import 'package:json_annotation/json_annotation.dart';

part 'type_notification.g.dart';

@JsonSerializable()
class TypeNotification {
  int? id;
  String? name;

  TypeNotification({this.id, this.name});

  factory TypeNotification.fromJson(Map<String, dynamic> json) =>
      _$TypeNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$TypeNotificationToJson(this);
}
