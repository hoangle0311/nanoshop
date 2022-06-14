import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nanoshop/src/core/bloc/bloc_with_state.dart';
import 'package:nanoshop/src/core/params/post_param.dart';
import 'package:nanoshop/src/core/params/token_param.dart';

import 'package:nanoshop/src/core/resource/data_state.dart';
import 'package:nanoshop/src/core/utils/log/log.dart';
import 'package:nanoshop/src/data/models/post_response_model/post_response_model.dart';
import 'package:nanoshop/src/domain/usecases/post_usecase/get_list_post_usecase.dart';

import '../../../domain/entities/post/post.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends BlocWithState<PostEvent, PostState> {
  final GetListPostUsecase _getListPostUsecase;

  int _page = 1;

  static const int postPerPage = 10;

  PostBloc(
    this._getListPostUsecase,
  ) : super(PostLoading()) {
    on<GetListPost>(_onLoadListPost);
    on<LoadMorePost>(_onLoadMoreList);
  }

  _onLoadListPost(
    GetListPost event,
    emit,
  ) async {
    DataState<PostResponseModel> dataState = await _getListPostUsecase.call(
      PostParam(
        page: _page,
        limit: postPerPage,
        token: event.tokenParam.token,
      ),
    );

    if (dataState is DataSuccess) {
      List<Post> posts = dataState.data!.data!.data!;

      emit(
        PostDone(
          posts: posts,
          hasMore: posts.length > postPerPage,
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(
        PostFailed(
          dioError: dataState.error,
        ),
      );
    }
  }

  _onLoadMoreList(
    LoadMorePost event,
    emit,
  ) async {
    if (state is PostDone) {
      _page++;
      Stream stream = runBlocProcess(
        () async* {
          if (!kReleaseMode) {
            await Future.delayed(
              Duration(seconds: 3),
            );
          }

          List<Post> posts = [];

          DataState<PostResponseModel> dataState = await _getListPostUsecase.call(
            PostParam(
              page: _page,
              limit: postPerPage,
              token: event.tokenParam.token,
            ),
          );

          if (dataState is DataSuccess) {
            posts.addAll(
              dataState.data!.data!.data!,
            );

            yield PostDone(
              posts: posts,
              hasMore: posts.length > postPerPage,
            );
          }

          if (dataState is DataFailed) {
            yield PostDone(
              posts: posts,
              hasMore: false,
            );
          }
        },
      );

      await for (final stateValue in stream) {
        var currentState = state as PostDone;
        List<Post> posts = [];
        posts.addAll(currentState.posts);
        posts.addAll(stateValue.posts);
        emit(
          currentState.copyWith(posts: posts, hasMore: stateValue.hasMore),
        );
      }
    }
  }
}
