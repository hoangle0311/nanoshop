import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/get_list_shop_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/shop_response_model/shop_response_model.dart';
import 'package:nanoshop/src/domain/entities/shop/shop.dart';
import 'package:nanoshop/src/domain/usecases/shop_usecase/get_list_shop_usecase.dart';

import '../../../domain/entities/filter_model/filter_model.dart';

part 'get_list_shop_state.dart';

class GetListShopCubit extends Cubit<GetListShopState> {
  final GetListShopUsecase _getListShopUsecase;

  GetListShopCubit(
    this._getListShopUsecase,
  ) : super(
          const GetListShopState(),
        );

  void onGetListShop({
    required TokenParam tokenParam,
    FilterModel? city,
  }) async {
    emit(
      state.copyWith(
        status: GetListShopStatus.loading,
      ),
    );

    String? provinceId;

    if (city != null) {
      provinceId = city.id;
    }

    final param = GetListShopParam(
      token: tokenParam.token,
      provinceId: provinceId,
    );

    try {
      DataState<ShopResponseModel> dataState =
          await _getListShopUsecase.call(param);
      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: GetListShopStatus.success,
            shops: dataState.data!.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: GetListShopStatus.failure,
            shops: [],
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GetListShopStatus.failure,
          shops: [],
        ),
      );
    }
  }
}
