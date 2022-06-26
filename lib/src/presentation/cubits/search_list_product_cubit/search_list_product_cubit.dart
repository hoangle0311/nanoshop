import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/filter_param.dart';
import 'package:nanoshop/src/core/params/search_product_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';

import '../../../data/responses/product_response_model/product_response_model.dart';
import '../../../domain/entities/manufacture/manufacturer.dart';
import '../../../domain/usecases/product_usecase/search_list_product_usecase.dart';

part 'search_list_product_state.dart';

class SearchListProductCubit extends Cubit<SearchListProductState> {
  final SearchListProductUsecase _searchListProductUsecase;

  SearchListProductCubit(
      this._searchListProductUsecase,
      ) : super(const SearchListProductState());

  static const _postPerPage = 10;

  onLoadMore() async {
    emit(
      state.copyWith(
        status: SearchListProductStatus.loading,
      ),
    );

    final param = SearchProductParam(
      token: state.param!.token,
      page: state.param!.page + 1,
      limit: _postPerPage,
      searchText: state.param!.searchText,
      manuId: state.param!.manuId,
      priceMax: state.param!.priceMax,
      priceMin: state.param!.priceMin,
    );

    try {
      DataState<ProductResponseModel> dataState =
      await _searchListProductUsecase.call(param);

      if (dataState is DataSuccess) {
        final List<Product> products = List.of(dataState.data!.data!.data!);

        emit(
          state.copyWith(
            status: SearchListProductStatus.success,
            products: state.products..addAll(List.of(products)) ,
            param: param,
            hasMore: products.length >= _postPerPage,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchListProductStatus.failure,
          hasMore: false,
        ),
      );
    }
  }

  onGetRelatedList({
    required TokenParam tokenParam,
    String? searchKey,
    FilterParam? filterParam,
  }) async {
    emit(
      state.copyWith(
        status: SearchListProductStatus.loading,
      ),
    );

    var priceMax, priceMin, manuId;

    if (filterParam != null) {
      if (filterParam.values != null) {
        priceMax = filterParam.values!.end.round();
        priceMin = filterParam.values!.start.round();
      }

      if (filterParam.manufacturer != Manufacturer.empty) {
        manuId = filterParam.manufacturer!.id;
      }
    }

    final param = SearchProductParam(
      token: tokenParam.token,
      page: 1,
      limit: _postPerPage,
      searchText: searchKey,
      manuId: manuId,
      priceMin: priceMin,
      priceMax: priceMax,
    );

    try {
      DataState<ProductResponseModel> dataState =
      await _searchListProductUsecase.call(param);

      if (dataState is DataSuccess) {
        final List<Product> products = List.of(dataState.data!.data!.data!);

        emit(
          state.copyWith(
            status: SearchListProductStatus.success,
            products: products,
            param: param,
            hasMore: products.length >= _postPerPage,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchListProductStatus.failure,
          hasMore: false,
        ),
      );
    }
  }
}
