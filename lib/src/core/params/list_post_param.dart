class DetailPostParam {
  final String token;
  final String id;
  final String type;

  DetailPostParam({
    this.type = "news",
    required this.id,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['type'] = type;
    data['id'] = id;

    return data;
  }
}
