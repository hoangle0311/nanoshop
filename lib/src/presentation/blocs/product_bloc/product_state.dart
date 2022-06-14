part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final List<Product> products;
  final ProductStatus status;
  final bool hasMore;

  const ProductState({
    this.products = const [],
    this.hasMore = false,
    this.status = ProductStatus.initial,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    bool? hasMore,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [
        products,
        status,
        hasMore,
      ];
}

// class ProductLoading extends ProductState {
//   ProductLoading() : super(products: []);

//   @override
//   List<Object?> get props => [];
// }

// class ProductDone extends ProductState {
//   const ProductDone({
//     required List<Product> products,
//   }) : super(products: products);

//   ProductDone copyWith({
//     required List<Product>? products,
//   }) {
//     return ProductDone(
//       products: products ?? this.products,
//     );
//   }

//   @override
//   List<Object> get props => [
//         products,
//       ];
// }

// class ProductFailed extends ProductState {
//   final DioError? error;

//   ProductFailed({
//     this.error,
//   }) : super(products: []);

//   @override
//   List<Object?> get props => [];
// }
