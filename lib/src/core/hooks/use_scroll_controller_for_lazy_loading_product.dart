import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/blocs.dart';

void onUseScrollControllerForLazyLoadingProduct(
  BuildContext context,
  ScrollController scrollController,
) {
  final maxScrollExtend = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.position.pixels;

  final bloc = BlocProvider.of<ProductBloc>(context);
  final state = bloc.state;
  final hasMore = bloc.state.hasMore;

  if (currentScroll >= maxScrollExtend &&
      hasMore &&
      state.status != ProductStatus.loading) {
    bloc.add(
      const LoadMoreListProductEvent(),
    );
  }
}
