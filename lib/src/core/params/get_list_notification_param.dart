class GetListNotificationParam {
  final String userId;
  final String type;
  final int page;
  final int limit;

  GetListNotificationParam({
    required this.userId,
    required this.type,
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['user_id'] = userId;
    data['type'] = type;
    data['page'] = page;
    data['limit'] = limit;

    return data;
  }
}
