part of 'local_product_bloc.dart';

abstract class LocalProductState extends Equatable {
  const LocalProductState();

  @override
  List<Object> get props => [];
}

class LocalProductLoading extends LocalProductState {}

class LocalProductDone extends LocalProductState {
  final List<Product> products;
  final Product? removeProduct;
  final Product? addProduct;

  const LocalProductDone({
    required this.products,
    this.removeProduct,
    this.addProduct,
  });

  @override
  List<Object> get props => [
        products,
      ];
}
