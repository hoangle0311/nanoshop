import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../config/styles/app_color.dart';
import '../../../config/styles/app_text_style.dart';
import '../../../core/hooks/onUseScrollControllerForLazyLoadingSearchProduct.dart';
import '../../../core/params/token_param.dart';
import '../../../domain/entities/product/product.dart';
import '../../../injector.dart';
import '../../cubits/search_list_product_cubit/search_list_product_cubit.dart';
import '../../ui/search_product/widgets/search_product_app_bar.dart';
import '../../views/components/product_widget/list_vertical_product_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<SearchListProductCubit>()
        ..onGetRelatedList(tokenParam: injector<TokenParam>()),
      child: Column(
        children: [
          AppBarSearch(),
          Expanded(
            child: BlocBuilder<SearchListProductCubit, SearchListProductState>(
              builder: (context, state) {
                if (state.products.isEmpty &&
                    state.status == SearchListProductStatus.loading) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                if (state.products.isNotEmpty) {
                  return _ListProductSearch(
                    listProduct: state.products,
                    hasMore: state.hasMore,
                  );
                }

                return Center(
                  child: Text(
                    'Không có sản phẩm nào phù hợp',
                    style: TextStyleApp.textStyle1
                        .copyWith(color: AppColors.primaryColor),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar _appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(),
      leadingWidth: 0,
      title: Container(
        height: 45,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            context.read<SearchListProductCubit>().onGetRelatedList(
              tokenParam: injector<TokenParam>(),
              searchKey: value,
            );
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            fillColor: Colors.white,
            filled: true,
            focusColor: AppColors.primaryColor,
            prefixIcon: Icon(
              Icons.search,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
    double top = MediaQuery.of(context).padding.top;
    return Container(
      // height: 122 + top,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(
              "assets/images/cham.png",
            ),
            alignment: Alignment.bottomRight,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.4), BlendMode.modulate)),
      ),
      // padding: EdgeInsets.only(top: 30, bottom: 20),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(
              ImagePath.backgroundAppBar,
              fit: BoxFit.fill,
            ),
          ),
          _appBar,
        ],
      ),
    );
  }
}

class _ListProductSearch extends HookWidget {
  final List<Product> listProduct;
  final bool hasMore;

  const _ListProductSearch({
    Key? key,
    required this.listProduct,
    required this.hasMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _mainScrollController = ScrollController();

    useEffect(() {
      _mainScrollController.addListener(
            () => onUseScrollControllerForLazyLoadingSearchProduct(
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
      child: ListVerticalProductWidget(
        products: listProduct,
        isShowLoading: hasMore,
      ),
    );
  }
}