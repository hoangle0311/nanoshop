class PostParam {
  final String token;
  final int limit;
  final int page;

  PostParam({
    required this.page,
    required this.limit,
    required this.token,
  });
}
