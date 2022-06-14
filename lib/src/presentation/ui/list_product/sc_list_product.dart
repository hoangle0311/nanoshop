import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nanoshop/src/core/hooks/use_scroll_controller_for_lazy_loading_product.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../blocs/blocs.dart';
import '../../blocs/local_product_bloc/local_product_bloc.dart';
import '../../views/components/buttons/button_with_title_widget.dart';
import '../../views/components/loading_widget/banner_loading.dart';
import '../../views/components/loading_widget/list_horizontal_category_loading.dart';
import '../../views/components/product_widget/list_vertical_product_widget.dart';

class ScListProductArgument {
  final String title;

  ScListProductArgument({
    required this.title,
  });
}

class ScListProduct extends StatelessWidget {
  final ScListProductArgument argument;

  static const _groupIdBanner = '1';

  const ScListProduct({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<ProductBloc>()
            ..add(
              GetListProductEvent(
                tokenParam: injector<TokenParam>(),
              ),
            ),
        ),
        BlocProvider(
          create: (_) => injector<GetBannerBloc>()
            ..add(
              GetBannerByGroupId(
                groupId: _groupIdBanner,
                tokenParam: injector<TokenParam>(),
              ),
            ),
        ),
      ],
      child: Scaffold(
        appBar: PageAppBar(
          title: argument.title,
        ),
        body: _Body(),
      ),
    );
  }
}

class _Body extends HookWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _mainScrollController = ScrollController();

    useEffect(() {
      _mainScrollController.addListener(
        () => onUseScrollControllerForLazyLoadingProduct(
          context,
          _mainScrollController,
        ),
      );
      return null;
    }, [
      _mainScrollController,
    ]);
    return SingleChildScrollView(
      controller: _mainScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: _BannerProduct(),
          ),
          _ListProduct(),
        ],
      ),
    );
  }
}

class _BannerProduct extends StatelessWidget {
  const _BannerProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBannerBloc, GetBannerState>(
      bloc: context.read<GetBannerBloc>(),
      builder: (context, state) {
        if (state is GetBannerDone) {
          if (state.banners.isNotEmpty) {
            return Container(
              height: 167,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LoadImageFromUrlWidget(
                  imageUrl: state.banners[0].bannerSrc ?? '',
                ),
              ),
            );
          }

          return Container();
        }
        if (state is GetBannerFailed) {
          return Container();
        }

        return const BannerLoading();
      },
    );
  }
}

class _ListProduct extends StatelessWidget {
  const _ListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: context.read<ProductBloc>(),
      builder: (context, state) {
        if (state.status == ProductStatus.loading && state.products.isEmpty) {
          return const ListHorizontalCategoryLoading();
        }

        if (state.products.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListVerticalProductWidget(
                products: state.products,
                isShowLoading: state.hasMore,
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
