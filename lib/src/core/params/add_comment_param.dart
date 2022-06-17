class AddCommentParam {
  final String token;
  final String userId;
  final String productId;
  final double countRate;
  // final String name;
  final String type;
  final String content;
  // final String phone;

  const AddCommentParam({
    required this.token,
    required this.userId,
    required this.productId,
    required this.countRate,
    // required this.name,
    required this.type,
    required this.content,
    // required this.phone,
  });
}
