class SearchProductParam {
  final String? searchText;
  final int page;
  final int limit;
  final int? priceMax;
  final int? priceMin;
  final String? manuId;

  SearchProductParam({
    this.searchText = '',
    required this.page,
    required this.limit,
    this.priceMax,
    this.priceMin,
    this.manuId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    if (searchText != null) {
      data['keyword'] = searchText;
    }
    if (priceMax != null) {
      data['fi_pmax'] = priceMax;
    }
    if (priceMin != null) {
      data['fi_pmin'] = priceMin;
    }
    if (manuId != null) {
      data['manu_id'] = manuId;
    }
    data['page'] = page;
    data['limit'] = limit;

    return data;
  }
}
