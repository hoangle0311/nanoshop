part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  final int index;

  const ProductEvent({
    required this.index,
  });

  @override
  List<Object> get props => [];
}

class GetListProductEvent extends ProductEvent {
  final TokenParam tokenParam;

  GetListProductEvent({
    required this.tokenParam,
  }) : super(index: 0);
}

class CheckRemoveFavouriteProductEvent extends ProductEvent {
  final Product product;

  CheckRemoveFavouriteProductEvent({
    required this.product,
  }) : super(index: 0);
}

class CheckAddFavouriteProductEvent extends ProductEvent {
  final Product product;

  CheckAddFavouriteProductEvent({
    required this.product,
  }) : super(index: 0);
}

class LoadMoreListProductEvent extends ProductEvent {
  const LoadMoreListProductEvent() : super(index: 0);
}
