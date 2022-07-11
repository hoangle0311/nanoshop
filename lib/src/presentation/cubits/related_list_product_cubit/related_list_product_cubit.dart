import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/related_product_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_related_list_product_usecase.dart';

part 'related_list_product_state.dart';

class RelatedListProductCubit extends Cubit<RelatedListProductState> {
  final GetRelatedListProductUsecase _getRelatedListProductUsecase;

  RelatedListProductCubit(
    this._getRelatedListProductUsecase,
  ) : super(const RelatedListProductState());

  onGetRelatedList(RelatedProductParam param) async {
    emit(
      state.copyWith(
        status: RelatedListProductStatus.loading,
      ),
    );
    try {
      DataState<List<Product>> dataState =
          await _getRelatedListProductUsecase.call(param);

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: RelatedListProductStatus.loading,
            products: List.of(dataState.data!),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: RelatedListProductStatus.failure,
        ),
      );
    }
  }
}
