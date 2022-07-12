class GetTypeNotificationParam {
  final String userId;

  GetTypeNotificationParam({
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['user_id'] = userId;

    return data;
  }
}
