import '../utils/log/log.dart';

class ProductParam {
  final String? categoryId;
  final int page;
  final String token;
  final int limit;
  final int? priceMax;
  final int? priceMin;
  final String? manuId;

  ProductParam({
    required this.page,
    required this.limit,
    required this.token,
    this.categoryId,
    this.priceMax,
    this.priceMin,
    this.manuId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    if (categoryId != null) {
      data['category_id'] = categoryId;
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
