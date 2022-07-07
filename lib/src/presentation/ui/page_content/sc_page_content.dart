import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../core/params/token_param.dart';
import '../../cubits/page_content_cubit/page_content_cubit.dart';

class PageContentArgument {
  final String id;
  final String type;
  final String title;

  const PageContentArgument({
    required this.id,
    required this.type,
    required this.title,
  });
}

class ScPageContent extends StatelessWidget {
  final PageContentArgument argument;

  const ScPageContent({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<PageContentCubit>()
        ..onGetPageContent(
          injector<TokenParam>(),
          argument.id,
          argument.type,
        ),
      child: Scaffold(
        appBar: PageAppBar(
          title: argument.title,
        ),
        body: BlocBuilder<PageContentCubit, PageContentState>(
          builder: (context, state) {
            if (state.status == PageContentStatus.loading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (state.status == PageContentStatus.success) {
              return SingleChildScrollView(
                child: Html(
                  data: state.pageContentModel?.content ?? '',
                ),
              );
            }

            return Center(
              child: Text(
                'Chưa cập nhật',
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
