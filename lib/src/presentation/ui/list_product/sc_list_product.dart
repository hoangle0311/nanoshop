import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/core/hooks/use_scroll_controller_for_lazy_loading_product.dart';
import 'package:nanoshop/src/core/params/filter_param.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../config/styles/app_color.dart';
import '../../blocs/blocs.dart';
import '../../views/components/loading_widget/banner_loading.dart';
import '../../views/components/loading_widget/list_horizontal_category_loading.dart';
import '../../views/components/product_widget/list_vertical_product_widget.dart';

class ScListProductArgument {
  final String title;
  final String? categoryId;

  ScListProductArgument({
    required this.title,
    this.categoryId,
  });
}

class ScListProduct extends StatelessWidget {
  final ScListProductArgument argument;

  static const _groupIdBanner = '15350';

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
                categoryId: argument.categoryId,
              ),
            ),
        ),
        BlocProvider(
          create: (_) => injector<GetBannerBloc>()
            ..add(
              GetBannerByGroupId(
                groupId: _groupIdBanner,
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
          _Header(),
          _ListProduct(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.success &&
            state.products.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '(Có ${state.products.length} sản phẩm phù hợp)',
                  style: TextStyleApp.textStyle2.copyWith(
                    color: AppColors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRouterEndPoint.FilterProduct)
                        .then(
                      (value) {
                        if (value != null) {
                          if (value is FilterParam) {
                            context.read<ProductBloc>().add(
                                  GetListProductEvent(
                                    filterParam: value,
                                  ),
                                );
                          }
                        }
                      },
                    );
                  },
                  child: Image.asset(
                    ImagePath.shortIcon,
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
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
                  imageUrl:
                      Environment.domain + (state.banners[0].bannerSrc ?? ''),
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
