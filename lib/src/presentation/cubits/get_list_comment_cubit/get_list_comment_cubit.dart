import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/params/get_list_comment_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';
import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/data/models/comment_response_model/comment_response_model.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_list_comment_usecase.dart';

import '../../../domain/entities/comment/comment.dart';
import '../../../domain/entities/product/product.dart';

part 'get_list_comment_state.dart';

class GetListCommentCubit extends Cubit<GetListCommentState> {
  final GetListCommentUsecase _getListCommentUsecase;

  GetListCommentCubit(
    this._getListCommentUsecase,
  ) : super(
          const GetListCommentState(
            page: 1,
          ),
        );

  void onInitialGetListComment({
    required TokenParam tokenParam,
    required Product product,
    int limit = 5,
  }) async {
    GetListCommentParam param = GetListCommentParam(
      token: tokenParam.token,
      type: 1,
      productId: product.id!,
      page: state.page,
      limit: state.limit,
    );

    emit(
      state.copyWith(
        page: 1,
        param: param,
        status: GetListCommentStatus.loading,
        limit: limit,
      ),
    );

    try {
      DataState<CommentResponseModel> dataState =
          await _getListCommentUsecase.call(
        param,
      );

      if (dataState is DataSuccess) {
        List<Comment> comments = List.of(dataState.data!.data!);

        emit(
          state.copyWith(
            page: state.page,
            status: GetListCommentStatus.success,
            limit: state.limit,
            param: param,
            comments: comments,
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            param: param,
            page: state.page,
            status: GetListCommentStatus.failure,
            limit: state.limit,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GetListCommentStatus.failure,
          param: param,
        ),
      );
    }
  }

  void onLoadMoreList() async {
    GetListCommentParam param = state.param!.copyWith(
      page: state.page + 1,
    );

    emit(
      state.copyWith(
        param: param,
        status: GetListCommentStatus.loading,
      ),
    );

    try {
      DataState<CommentResponseModel> dataState =
          await _getListCommentUsecase.call(
        param,
      );

      if (dataState is DataSuccess) {
        List<Comment> comments = List.of(dataState.data!.data!);

        emit(
          state.copyWith(
            page: param.page,
            status: GetListCommentStatus.success,
            limit: param.limit,
            hasMore: comments.length >= param.limit,
            comments: state.comments
              ..addAll(
                List.of(comments),
              ),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            page: state.page,
            param: param,
            status: GetListCommentStatus.failure,
            limit: state.limit,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          param: param,
          status: GetListCommentStatus.failure,
        ),
      );
    }
  }
}
