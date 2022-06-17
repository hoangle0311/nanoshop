class RelatedProductParam {
  final String productId;
  final String token;

  const RelatedProductParam({
    required this.productId,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['_id'] = productId;

    return data;
  }
}
