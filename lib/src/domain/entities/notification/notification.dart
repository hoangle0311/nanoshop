import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notifications extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? link;
  final String? type;
  @JsonKey(name: "recipient_id")
  final String? recipientId;
  @JsonKey(name: "sender_id")
  final String? senderId;
  final String? unread;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;

  const Notifications({
    this.id,
    this.title,
    this.description,
    this.link,
    this.type,
    this.recipientId,
    this.senderId,
    this.unread,
    this.createdAt,
    this.updatedAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return _$NotificationsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
      ];
}
