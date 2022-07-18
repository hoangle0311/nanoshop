import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:dio/dio.dart';
import 'package:nanoshop/src/core/params/category_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';

import '../../../core/resource/data_state.dart';
import '../../../data/responses/category_response_model/category_response_model.dart';
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
    DataState<List<Category>> dataState =
        await _getListCategoryUsecase.call(
      CategoryParam(
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
          categories: dataState.data!,
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
