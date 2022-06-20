part of 'get_list_notification_cubit.dart';

enum GetListNotificationStatus {
  initial,
  loading,
  success,
  fail,
}

class GetListNotificationState extends Equatable {
  final GetListNotificationStatus status;
  final GetListNotificationParam? param;
  final List<Notifications> notifications;
  final bool hasMore;

  const GetListNotificationState({
    this.status = GetListNotificationStatus.initial,
    this.param,
    this.hasMore = true,
    this.notifications = const [],
  });

  GetListNotificationState copyWith({
    GetListNotificationStatus? status,
    GetListNotificationParam? param,
    List<Notifications>? notifications,
    bool? hasMore,
  }) {
    return GetListNotificationState(
      status: status ?? this.status,
      param: param ?? this.param,
      hasMore: hasMore ?? this.hasMore,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [
        status,
        param,
        hasMore,
        notifications,
      ];
}
