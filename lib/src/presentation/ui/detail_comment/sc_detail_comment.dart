import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../config/styles/app_color.dart';
import '../../../core/hooks/use_scroll_controller_for_lazy_loading_comment.dart';
import '../../../core/params/token_param.dart';
import '../../cubits/get_list_comment_cubit/get_list_comment_cubit.dart';
import '../../views/components/comment_widget/comment_list_tile.dart';

class ScDetailComment extends StatelessWidget {
  final Product product;

  const ScDetailComment({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<GetListCommentCubit>()
        ..onInitialGetListComment(
          product: product,
        ),
      child: Scaffold(
        appBar: const PageAppBar(title: "Bình luận"),
        body: BlocBuilder<GetListCommentCubit, GetListCommentState>(
          buildWhen: (pre, cur) {
            return pre.status != cur.status;
          },
          builder: (context, state) {
            if (state.status == GetListCommentStatus.loading &&
                state.comments.isEmpty) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (state.comments.isNotEmpty) {
              return _ListComment();
            }

            return Center(
              child: Text(
                'Lỗi khi tải bình luận ',
                style: TextStyleApp.textStyle2.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListComment extends HookWidget {
  const _ListComment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _mainScrollController = ScrollController();

    useEffect(() {
      _mainScrollController.addListener(
        () => useScrollControllerForLazyLoadingComment(
          context,
          _mainScrollController,
        ),
      );
      return null;
    }, [
      _mainScrollController,
    ]);

    return BlocBuilder<GetListCommentCubit, GetListCommentState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ...List.generate(
                  state.comments.length,
                      (index) => CommentListTile(
                    comment: state.comments[index],
                  ),
                ),
                if(state.hasMore)
                  Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
            // child: ListVerticalProductWidget(
            //   products: state.products,
            //   isShowLoading: state.hasMore,
            // ),
            );
      },
    );
  }
}
