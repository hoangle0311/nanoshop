import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/pages/pages.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../core/params/token_param.dart';
import '../../blocs/post_bloc/post_bloc.dart';

class ScListNews extends StatelessWidget {
  const ScListNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => injector<PostBloc>()
        ..add(
          GetListPost(
            tokenParam: injector<TokenParam>(),
          ),
        ),
      child: Scaffold(
        appBar: const PageAppBar(
          title: "Tin tức",
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state.status == PostStatus.loading && state.posts.isEmpty) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (state.posts.isNotEmpty) {
              return PostPage(
                showAppBar: false,
              );
            }

            return Center(
              child: Text(
                'Hiện chưa có tin tức nào',
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


