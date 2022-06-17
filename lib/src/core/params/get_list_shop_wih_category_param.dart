class GetListOrderParam {
  final String token;
  final String categoryId;
  final int page;
  final int limit;

  GetListOrderParam({
    required this.token,
    required this.categoryId,
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['category_id'] = categoryId;
    data['page'] = page;
    data['limit'] = limit;

    return data;
  }
}
