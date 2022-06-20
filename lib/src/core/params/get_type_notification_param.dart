class GetTypeNotificationParam {
  final String userId;
  final String token;

  GetTypeNotificationParam({
    required this.userId,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['user_id'] = userId;

    return data;
  }
}
