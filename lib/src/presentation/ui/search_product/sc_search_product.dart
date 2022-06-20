import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/ui/search_product/widgets/search_product_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/remove_focus_widget/remove_focus_widget.dart';

import '../../../config/styles/app_text_style.dart';
import '../../../core/params/token_param.dart';
import '../../../domain/entities/product/product.dart';
import '../../cubits/search_list_product_cubit/search_list_product_cubit.dart';
import '../../views/components/product_widget/list_vertical_product_widget.dart';

class ScSearchProduct extends StatefulWidget {
  const ScSearchProduct({Key? key}) : super(key: key);

  @override
  State<ScSearchProduct> createState() => _ScSearchProductState();
}

class _ScSearchProductState extends State<ScSearchProduct> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<SearchListProductCubit>()
        ..onGetRelatedList(tokenParam: injector<TokenParam>()),
      child: RemoveFocusWidget(
        child: Scaffold(
          appBar: SearchAppBar(
            onChanged: (value) {},
          ),
          body: BlocBuilder<SearchListProductCubit, SearchListProductState>(
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
                return _ListProduct(
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
      ),
    );
  }
}

class _ListProduct extends StatefulWidget {
  final List<Product> listProduct;
  final bool hasMore;

  const _ListProduct({
    Key? key,
    required this.listProduct,
    required this.hasMore,
  }) : super(key: key);

  @override
  __ListProductState createState() => __ListProductState();
}

class __ListProductState extends State<_ListProduct> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          context.read<SearchListProductCubit>().onLoadMore();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: ListVerticalProductWidget(
        products: widget.listProduct,
        isShowLoading: widget.hasMore,
      ),
    );
  }
}
