import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/domain/entities/post/post.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/params/token_param.dart';
import '../../blocs/post_bloc/post_bloc.dart';
import '../../cubits/get_detail_post_cubit/get_detail_post_cubit.dart';
import '../../views/components/app_bar/main_app_bar.dart';

class ScDetailPost extends HookWidget {
  final int initialPage;

  const ScDetailPost({
    Key? key,
    required this.initialPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(
      initialPage: initialPage,
    );

    return Scaffold(
      appBar: const PageAppBar(
        title: 'Trượt ←→ để xem tin tức ',
      ),
      body: BlocBuilder<PostBloc, PostState>(
        bloc: context.read<PostBloc>(),
        builder: (context, state) {
          if (state.posts.isNotEmpty) {
            return NotificationListener(
              onNotification: (notification) {
                if (notification is OverscrollNotification) {
                  context.read<PostBloc>().add(
                        LoadMorePost(
                          tokenParam: injector<TokenParam>(),
                        ),
                      );
                  return true;
                } else {
                  return false;
                }
              },
              child: PageView(
                controller: pageController,
                children: state.posts.map((e) {
                  return _Detail(
                    post: e,
                  );
                }).toList(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  final Post post;

  const _Detail({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<GetDetailPostCubit>()
        ..onGetDetail(
          injector<TokenParam>(),
          post.newsId!,
        ),
      child: BlocBuilder<GetDetailPostCubit, GetDetailPostState>(
        builder: (context, state) {
          if (state.status == GetDetailPostStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state.status == GetDetailPostStatus.success) {
            return SingleChildScrollView(
              child: Html(
                data: state.post.newsDesc ?? '',
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
