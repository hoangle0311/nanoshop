part of 'related_list_product_cubit.dart';

enum RelatedListProductStatus {
  initial,
  loading,
  success,
  failure,
}

class RelatedListProductState extends Equatable {
  final RelatedListProductStatus status;
  final List<Product> products;

  const RelatedListProductState({
    this.products = const [],
    this.status = RelatedListProductStatus.initial,
  });

  RelatedListProductState copyWith({
    RelatedListProductStatus? status,
    List<Product>? products,
  }) {
    return RelatedListProductState(
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        products,
        status,
      ];
}
