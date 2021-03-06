import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/post_bloc/post_bloc.dart';

import '../../injector.dart';
import '../bloc/bloc_with_state.dart';
import '../params/token_param.dart';
import '../utils/log/log.dart';

void onUseScrollControllerForLazyLoadingPost(
  BuildContext context,
  ScrollController scrollController,
) {
  final maxScrollExtend = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.position.pixels;

  final bloc = BlocProvider.of<PostBloc>(context);
  final state = bloc.state;
  final hasMore = bloc.state.hasMore;

  if (currentScroll >= maxScrollExtend &&
      hasMore &&
      state.status != PostStatus.loading) {
    bloc.add(
      LoadMorePost(
        tokenParam: injector<TokenParam>(),
      ),
    );
  }
}
