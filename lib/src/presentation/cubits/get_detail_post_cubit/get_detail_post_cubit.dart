import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoshop/src/core/params/list_post_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';
import 'package:nanoshop/src/domain/usecases/post_usecase/detail_post_usecase.dart';

import '../../../data/responses/list_post_response_model/list_post_response_model.dart';

part 'get_detail_post_state.dart';

class GetDetailPostCubit extends Cubit<GetDetailPostState> {
  final DetailPostUsecase _detailPostUsecase;

  GetDetailPostCubit(this._detailPostUsecase)
      : super(
          const GetDetailPostState(),
        );

  void onGetDetail(
    String id,
  ) async {
    emit(
      state.copyWith(
        status: GetDetailPostStatus.loading,
      ),
    );

    try {
      DataState<DetailPostResponseModel> dataState =
          await _detailPostUsecase.call(DetailPostParam(
        id: id,
      ));

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            status: GetDetailPostStatus.success,
            post: dataState.data!.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: GetDetailPostStatus.fail,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GetDetailPostStatus.fail,
        ),
      );
    }
  }
}
