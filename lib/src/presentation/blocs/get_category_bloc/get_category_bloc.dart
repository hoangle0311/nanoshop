import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:dio/dio.dart';
import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/data/models/category_response_model/category_response_model.dart';

import '../../../core/resource/data_state.dart';
import '../../../domain/entities/category/category.dart';
import '../../../domain/usecases/category_usecase/get_list_category_usecase.dart';

part 'get_category_event.dart';

part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  final GetListCategoryUsecase _getListCategoryUsecase;

  GetCategoryBloc(
    this._getListCategoryUsecase,
  ) : super(GetCategoryLoading()) {
    on<GetListCategoryEvent>(_getListCategory);
  }

  _getListCategory(
    GetListCategoryEvent event,
    Emitter emit,
  ) async {
    DataState<CategoryResponseModel> dataState =
        await _getListCategoryUsecase.call(
      CategoryParam(
        token: event.tokenParam.token,
        type: "product",
      ),
    );

    if (kDebugMode) {
      await Future.delayed(
        const Duration(seconds: 3),
      );
    }

    if (dataState is DataSuccess) {
      emit(
        GetCategoryDone(
          categories: dataState.data!.data!,
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        GetCategoryFailed(
          error: dataState.error,
        ),
      );
    }
  }
}
