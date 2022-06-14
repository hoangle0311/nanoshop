import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/domain/usecases/domain_layer_usecase.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_list_favourite_product_local_usecase.dart';

import '../../../domain/entities/product/product.dart';

part 'local_product_event.dart';
part 'local_product_state.dart';

class LocalProductBloc extends Bloc<LocalProductEvent, LocalProductState> {
  final GetListFavouriteProductLocalUsecase
      _getListFavouriteProductLocalUsecase;
  final AddFavouriteProductLocalUsecase _addFavouriteProductLocalUsecase;
  final RemoveFavouriteProductLocalUsecase _removeFavouriteProductLocalUsecase;

  LocalProductBloc(
    this._getListFavouriteProductLocalUsecase,
    this._addFavouriteProductLocalUsecase,
    this._removeFavouriteProductLocalUsecase,
  ) : super(LocalProductLoading()) {
    on<LocalProductEvent>(_onGetList);
    on<AddFavouriteProductEvent>(_onAddProduct);
    on<RemoveFavouriteProductEvent>(_onRemoveProduct);
  }

  Future<List<Product>> _getList() async {
    return await _getListFavouriteProductLocalUsecase.call(null);
  }

  _onGetList(
    event,
    emit,
  ) async {
    List<Product> products = await _getList();

    emit(
      LocalProductDone(
        products: products,
      ),
    );
  }

  _onAddProduct(
    event,
    emit,
  ) async {
    await _addFavouriteProductLocalUsecase.call(event.product);

    List<Product> products = await _getList();

    emit(
      LocalProductDone(
        products: products,
        addProduct: event.product,
      ),
    );
  }

  _onRemoveProduct(
    event,
    emit,
  ) async {
    await _removeFavouriteProductLocalUsecase.call(event.product);

    List<Product> products = await _getList();

    emit(
      LocalProductDone(
        products: products,
        removeProduct: event.product,
      ),
    );
  }
}
