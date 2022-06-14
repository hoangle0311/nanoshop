import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nanoshop/src/core/bloc/bloc_with_state.dart';
import 'package:nanoshop/src/core/params/product_param.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/data/models/product_response_model/product_response_model.dart';
import 'package:nanoshop/src/domain/usecases/domain_layer_usecase.dart';

import '../../../core/params/token_param.dart';
import '../../../core/resource/data_state.dart';
import '../../../domain/entities/product/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BlocWithState<ProductEvent, ProductState> {
  final GetListProductRemoteUsecase _getListProductUsecase;
  final GetListFavouriteProductLocalUsecase _getListFavouriteProductUsecase;

  int _page = 1;

  static const postPerPage = 10;

  // final List<Product> _products = [];

  ProductBloc(
    this._getListProductUsecase,
    this._getListFavouriteProductUsecase,
  ) : super(
          const ProductState(),
        ) {
    on<GetListProductEvent>(_onGetListProduct);
    on<LoadMoreListProductEvent>(_onLoadMore);
    on<CheckRemoveFavouriteProductEvent>(_onCheckRemoveFavourite);
    on<CheckAddFavouriteProductEvent>(_onCheckAddFavourite);
  }

  // Lấy dữ liệu favourite từ local ra
  Future<List<Product>> _getListFavouriteProduct() async {
    return await _getListFavouriteProductUsecase.call(null);
  }

  // Check dữ liệu với list product đưa vào với list Product Favourite
  Future<List<Product>> _checkProductHasFavourite(
    List<Product> checkProducts,
  ) async {
    final List<Product> products = [];

    List<Product> listFavouriteProduct = await _getListFavouriteProduct();

    if (listFavouriteProduct.isNotEmpty) {
      for (var element1 in checkProducts) {
        var check = false;

        inner:
        for (var element2 in listFavouriteProduct) {
          if (element1.id == element2.id) {
            check = true;
            products.add(element2);
            break inner;
          }
        }

        if (!check) {
          products.add(element1);
        }
      }
      // for (int i = 0; i < checkProducts.length; i++) {
      //   if (listFavouriteProduct.contains(checkProducts[i])) {
      //     products.add(
      //       checkProducts.elementAt(i).copyWith(
      //             isLiked: 1,
      //           ),
      //     );

      //     continue;
      //   }

      //   products.add(checkProducts.elementAt(i));
      // }

      return products;
    } else {
      products.addAll(checkProducts);

      return products;
    }
  }

  _onGetListProduct(
    GetListProductEvent event,
    Emitter emit,
  ) async {
    List<Product> products = [];

    emit(
      state.copyWith(
        status: ProductStatus.loading,
      ),
    );

    DataState<ProductResponseModel> dataState =
        await _getListProductUsecase.call(
      ProductParam(
        page: _page,
        limit: postPerPage,
        token: event.tokenParam.token,
      ),
    );

    if (dataState is DataSuccess) {
      products.addAll(
        dataState.data!.data!.data!,
      );

      // List<Product> listCheckProduct =
      //     await _checkProductHasFavourite(products);

      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: List.of(products),
          hasMore: products.length >= postPerPage,
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        state.copyWith(
          status: ProductStatus.failure,
        ),
      );
    }
  }

  _onCheckAddFavourite(
    CheckAddFavouriteProductEvent event,
    emit,
  ) async {
    List<Product> products = state.products.map(
      (e) {
        if (e == event.product) {
          return e.copyWith(isLiked: 1);
        }

        return e;
      },
    ).toList();

    emit(
      state.copyWith(
        status: state.status,
        products: List.of(products),
        hasMore: state.hasMore,
      ),
    );
  }

  _onCheckRemoveFavourite(
    CheckRemoveFavouriteProductEvent event,
    emit,
  ) async {
    List<Product> products = state.products.map(
      (e) {
        if (e == event.product) {
          return e.copyWith(isLiked: 0);
        }

        return e;
      },
    ).toList();

    emit(
      state.copyWith(
        status: state.status,
        products: List.of(products),
        hasMore: state.hasMore,
      ),
    );
  }

  _onLoadMore(
    event,
    Emitter emit,
  ) async {
    _page++;

    List<Product> products = [];

    if (!kReleaseMode) {
      await Future.delayed(
        const Duration(seconds: 5),
      );
    }

    emit(
      state.copyWith(
        status: ProductStatus.loading,
      ),
    );

    DataState response = await _getListProductUsecase.call(
      ProductParam(
        page: _page,
        limit: postPerPage,
        token: event.tokenParam.token,
      ),
    );

    if (response is DataSuccess) {
      products.addAll(response.data);

      List<Product> listCheckProduct =
          await _checkProductHasFavourite(products);

      emit(
        state.copyWith(
          status: ProductStatus.success,
          products: List.of(state.products)..addAll(listCheckProduct),
          hasMore: listCheckProduct.length >= postPerPage,
        ),
      );
    }
  }
}
