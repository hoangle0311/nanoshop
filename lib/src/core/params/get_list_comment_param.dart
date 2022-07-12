class GetListCommentParam {
  final int type;
  final String productId;
  final int page;
  final int limit;

  const GetListCommentParam({
    required this.type,
    required this.productId,
    required this.page,
    required this.limit,
  });

  GetListCommentParam copyWith({
    String? token,
    int? type,
    String? productId,
    int? page,
    int? limit,
  }) {
    return GetListCommentParam(
      type: type ?? this.type,
      productId: productId ?? this.productId,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['type'] = type;
    data['object_id'] = productId;
    data['page'] = page;
    data['limit'] = limit;

    return data;
  }
}
