part of 'get_type_notification_cubit.dart';

enum GetTypeNotificationStatus {
  initial,
  loading,
  success,
  fail,
}

class GetTypeNotificationState extends Equatable {
  final GetTypeNotificationStatus status;
  final List<TypeNotification> listType;

  const GetTypeNotificationState({
    this.status = GetTypeNotificationStatus.initial,
    this.listType = const [],
  });

  GetTypeNotificationState copyWith({
    GetTypeNotificationStatus? status,
    List<TypeNotification>? listType,
  }) {
    return GetTypeNotificationState(
      status: status ?? this.status,
      listType: listType ?? this.listType,
    );
  }

  @override
  List<Object?> get props => [
        status,
        listType,
      ];
}
