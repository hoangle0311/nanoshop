class RelatedProductParam {
  final String productId;

  const RelatedProductParam({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['_id'] = productId;

    return data;
  }
}
