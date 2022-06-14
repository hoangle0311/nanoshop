// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'local_product_bloc.dart';

abstract class LocalProductEvent extends Equatable {
  const LocalProductEvent();

  @override
  List<Object> get props => [];
}

class GetListFavouriteProductEvent extends LocalProductEvent {}

class AddFavouriteProductEvent extends LocalProductEvent {
  final Product product;
  const AddFavouriteProductEvent({
    required this.product,
  });
}

class RemoveFavouriteProductEvent extends LocalProductEvent {
  final Product product;
  const RemoveFavouriteProductEvent({
    required this.product,
  });
}
