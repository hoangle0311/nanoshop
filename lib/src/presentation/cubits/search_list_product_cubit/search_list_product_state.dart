part of 'search_list_product_cubit.dart';

enum SearchListProductStatus {
  initial,
  loading,
  success,
  failure,
}

class SearchListProductState extends Equatable {
  final SearchListProductStatus status;
  final List<Product> products;
  final SearchProductParam? param;
  final bool hasMore;

  const SearchListProductState({
    this.products = const [],
    this.status = SearchListProductStatus.initial,
    this.param,
    this.hasMore = true,
  });

  SearchListProductState copyWith({
    SearchListProductStatus? status,
    List<Product>? products,
    SearchProductParam? param,
    bool? hasMore,
  }) {
    return SearchListProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      param: param ?? this.param,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
        products,
        status,
        param,
        hasMore,
      ];
}
