class DetailPostParam {
  final String id;
  final String type;

  DetailPostParam({
    this.type = "news",
    required this.id,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data['type'] = type;
    data['id'] = id;

    return data;
  }
}
