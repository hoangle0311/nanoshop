class ListFlashSaleWithListProductParam {
  final String token;
  final String groupId;
  final int limit;
  final int page;

  ListFlashSaleWithListProductParam({
    required this.token,
    required this.groupId,
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['group_id'] = groupId;
    data['page'] = page;
    data['limit'] = limit;

    return data;
  }
}
