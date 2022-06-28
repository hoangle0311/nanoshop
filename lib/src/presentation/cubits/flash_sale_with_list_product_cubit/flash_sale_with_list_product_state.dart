part of 'flash_sale_with_list_product_cubit.dart';

enum Status {
  initial,
  loading,
  success,
  failure,
}

class FlashSaleWithListProductState extends Equatable {
  final Status status;
  final List<Product> products;
  final bool hasMore ;

  const FlashSaleWithListProductState({
    this.status = Status.initial,
    this.products = const [],
    this.hasMore = true,
  });

  FlashSaleWithListProductState copyWith({
    Status? status,
    bool? hasMore,
    List<Product>? products,
  }) {
    return FlashSaleWithListProductState(
      status: status ?? this.status,
      hasMore: hasMore ?? this.hasMore,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [
        status,
        products,
    hasMore,
      ];
}
