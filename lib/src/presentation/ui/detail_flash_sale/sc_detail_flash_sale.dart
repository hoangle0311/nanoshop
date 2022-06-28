import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';

import 'package:nanoshop/src/domain/entities/flash_sale/flash_sale.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/product_widget/list_vertical_product_widget.dart';

import '../../../core/hooks/use_scroll_controller_for_lazy_loading_flash_sale.dart';
import '../../../core/hooks/use_scroll_controller_for_lazy_loading_product.dart';
import '../../../core/params/token_param.dart';
import '../../cubits/flash_sale_with_list_product_cubit/flash_sale_with_list_product_cubit.dart';

class ScDetailFlashSale extends StatelessWidget {
  final FlashSale flashSale;

  const ScDetailFlashSale({
    Key? key,
    required this.flashSale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<FlashSaleWithListProductCubit>()
        ..onGetListProduct(
          token: injector<TokenParam>().token,
          groupId: flashSale.promotionId ?? '0',
        ),
      child: Scaffold(
        appBar: PageAppBar(
          title: flashSale.name ?? '',
        ),
        body: BlocBuilder<FlashSaleWithListProductCubit,
            FlashSaleWithListProductState>(
          builder: (BuildContext context, state) {
            if (state.status == Status.loading && state.products.isEmpty) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if (state.products.isNotEmpty) {
              return _ListBody(
                flashSale: flashSale,
              );
            }

            return Center(
              child: Text(
                'Danh sách sản phẩm trống',
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

class _ListBody extends HookWidget {
  final FlashSale flashSale;

  const _ListBody({
    Key? key,
    required this.flashSale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _mainScrollController = ScrollController();

    useEffect(() {
      _mainScrollController.addListener(
        () => useScrollControllerForLazyLoadingFlashSale(
          context,
          _mainScrollController,
          flashSale.promotionId ?? '',
        ),
      );
      return null;
    }, [
      _mainScrollController,
    ]);

    return BlocBuilder<FlashSaleWithListProductCubit,
        FlashSaleWithListProductState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: ListVerticalProductWidget(
            products: state.products,
            isShowLoading: state.hasMore,
          ),
        );
      },
    );
  }
}
