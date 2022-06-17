part of 'detail_product_cubit.dart';

enum DetailProductStatus {
  initial,
  loading,
  success,
  failure,
}

class DetailProductState extends Equatable {
  final DetailProductStatus status;
  final Product? product;
  final String? message;

  const DetailProductState({
    this.status = DetailProductStatus.initial,
    this.product,
    this.message,
  });

  DetailProductState copyWith({
    DetailProductStatus? status,
    Product? product,
    String? message,
  }) {
    return DetailProductState(
      product: product ?? this.product,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        product,
        message,
        status,
      ];
}
