class PageContentParam {
  final String token;
  final String id;
  final String type;

  const PageContentParam({
    required this.token,
    required this.id,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['type'] = type;

    return data;
  }
}
