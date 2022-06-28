import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/blocs/blocs.dart';

import '../../presentation/cubits/flash_sale_with_list_product_cubit/flash_sale_with_list_product_cubit.dart';
import '../params/token_param.dart';

void useScrollControllerForLazyLoadingFlashSale(
  BuildContext context,
  ScrollController scrollController,
  String groupId,
) {
  final maxScrollExtend = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.position.pixels;

  final bloc = BlocProvider.of<FlashSaleWithListProductCubit>(context);
  final state = bloc.state;
  final hasMore = bloc.state.hasMore;

  if (currentScroll >= (maxScrollExtend - 200) &&
      hasMore &&
      state.status != ProductStatus.loading) {
    bloc.onLoadMore(token: injector<TokenParam>().token, groupId: groupId);
  }
}
