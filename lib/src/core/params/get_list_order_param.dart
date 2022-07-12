class GetListOrderParam {
  final String userId;
  final int orderStatus;
  final int page;
  final int limit;

  GetListOrderParam({
    required this.orderStatus,
    required this.userId,
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['user_id'] = userId;
    data['order_status'] = orderStatus;
    data['page'] = page;
    data['limit'] = limit;

    return data;
  }
}
