import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/chat/screen_chat.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';
import 'package:nanoshop/src/core/params/detail_product_param.dart';
import 'package:nanoshop/src/core/toast/toast.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'package:nanoshop/src/presentation/ui/detail_product/widgets/detail_stats_product_container.dart';
import 'package:nanoshop/src/presentation/ui/detail_product/widgets/name_product_container.dart';
import 'package:nanoshop/src/presentation/ui/detail_product/widgets/rating_detail_product.dart';
import 'package:nanoshop/src/presentation/views/components/comment_widget/comment_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../chat/list_chat.dart';
import '../../../chat/models/data_model.dart';
import '../../../core/assets/image_path.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/params/related_product_param.dart';
import '../../../core/params/token_param.dart';
import '../../../domain/entities/product/product.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../cubits/detail_product_cubit/detail_product_cubit.dart';
import '../../cubits/get_list_comment_cubit/get_list_comment_cubit.dart';
import '../../cubits/related_list_product_cubit/related_list_product_cubit.dart';
import '../../views/bottom_sheet/bottom_sheet_product.dart';
import '../../views/components/banner_widget/slide_detail_product_widget.dart';
import '../../views/components/product_widget/list_horizontal_product_widget.dart';
import 'widgets/detail_field_product_container.dart';

class ScDetailProduct extends StatefulWidget {
  final Product product;

  const ScDetailProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  static const _sizedBoxh5 = SizedBox(
    height: 5,
  );

  @override
  State<ScDetailProduct> createState() => _ScDetailProductState();
}

class _ScDetailProductState extends State<ScDetailProduct>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _colorAnimationController;
  late Animation _colorTween;
  late Animation _opacityTween;

  @override
  void initState() {
    super.initState();
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
    _colorTween = ColorTween(
      begin: AppColors.primaryColor,
      end: Colors.white,
    ).animate(_colorAnimationController);
    _opacityTween = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(_colorAnimationController);
    _scrollController.addListener(_onScroll);
  }

  _onScroll() {
    _colorAnimationController
        .animateTo(_scrollController.position.pixels / 350);
  }

  @override
  void dispose() {
    super.dispose();
    _colorAnimationController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return injector<DetailProductCubit>()
              ..onGetDetail(DetailProductParam(
                token: injector<TokenParam>().token,
                id: int.parse(widget.product.id!),
                type: "product",
              ));
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return injector<GetListCommentCubit>()
              ..onInitialGetListComment(
                product: widget.product,
                tokenParam: injector<TokenParam>(),
                limit: 5,
              );
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return injector<RelatedListProductCubit>()
              ..onGetRelatedList(
                RelatedProductParam(
                  productId: widget.product.id!,
                  token: injector<TokenParam>().token,
                ),
              );
          },
        ),
      ],
      child: BlocBuilder<DetailProductCubit, DetailProductState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.grey,
            body: Stack(
              children: [
                if (state.status == DetailProductStatus.success)
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        DetailProductSliderImage(
                          images: state.product!.images ?? [],
                        ),
                        NameProductContainer(
                          product: state.product!,
                        ),
                        // ShareListWidget(
                        //   model: state.detailProductModel,
                        // ),
                        ScDetailProduct._sizedBoxh5,
                        DetailFieldProductFragment(
                          title: 'Thông số sản phẩm',
                          product: state.product!,
                        ),
                        ScDetailProduct._sizedBoxh5,
                        DetailWithTittleProductFragment(
                          title: 'mô tả sản phẩm',
                          product: state.product!,
                        ),
                        ScDetailProduct._sizedBoxh5,
                        RatingDetailProduct(
                          product: state.product!,
                        ),
                        const _RatingContainer(),
                        const _HorizontalListProduct(),
                        // RatingProductFragment(
                        //   commentBloc: _commentBloc,
                        //   model: state.detailProductModel,
                        // ),
                        // ListHorizontalProduct(
                        //   title: 'sản phẩm tương tự',
                        // ),
                      ],
                    ),
                  ),
                if (state.status == DetailProductStatus.loading)
                  Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedBuilder(
                    animation: _colorAnimationController,
                    builder: (context, child) => Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Opacity(
                            opacity: _opacityTween.value,
                            child: Image.asset(
                              ImagePath.backgroundAppBar,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).padding.top,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                children: [
                                  Platform.isAndroid
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: _colorTween.value,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: _colorTween.value,
                                          ),
                                        ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        widget.product.name ?? '',
                                        style: TextStyleApp.textStyle1.copyWith(
                                          color: AppColors.white.withOpacity(
                                            _opacityTween.value,
                                          ),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _BottomNavigationBar(
              product: widget.product,
            ),
          );
        },
      ),
    );
  }
}

class _HorizontalListProduct extends StatelessWidget {
  const _HorizontalListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RelatedListProductCubit, RelatedListProductState>(
      builder: (context, state) {
        if (state.products.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Sản phẩm tương tự",
                  style: TextStyleApp.textStyle7.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              ListHorizontalProductWidget(
                products: state.products,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class _RatingContainer extends StatelessWidget {
  const _RatingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: BlocBuilder<GetListCommentCubit, GetListCommentState>(
        builder: (context, state) {
          if (state.comments.isNotEmpty) {
            return Column(
              children: List.generate(
                state.comments.length,
                (index) => CommentListTile(
                  comment: state.comments[index],
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Chưa có bình luận nào',
                style: TextStyleApp.textStyle1.copyWith(
                  color: AppColors.black,
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final Product product;

  const _BottomNavigationBar({
    Key? key,
    required this.product,
  }) : super(key: key);

  Widget _iconWithText(
    String title,
    IconData iconData, {
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyleApp.textStyle1.copyWith(
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var shoppingCartCubit = context.read<ShoppingCartCubit>();

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HexColor("#030102"),
                    HexColor("#3A3A3A"),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _iconWithText(
                      'Chat ngay',
                      Icons.message,
                      onTap: () async {
                        var authBloc = context.read<AuthenticationBloc>();
                        var authState = authBloc.state;

                        if (authState.user != UserLogin.empty) {
                          DataModel dataModel =
                              DataModel(authState.user.userId);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (authState.user.type == '3') {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ListChat(
                                id: 'Admin',
                              ),
                            ));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ScreenChat(
                                arguments: ModelChatScreen(
                                  name: "Admin",
                                  currentUserNo: authState.user.userId!,
                                  peerNo: "Admin",
                                  prefs: prefs,
                                  model: dataModel,
                                ),
                              ),
                            ));
                          }
                        } else {
                          Navigator.of(context)
                              .pushNamed(AppRouterEndPoint.LOGIN);
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: _iconWithText(
                      'Thêm vào giỏ hàng',
                      Icons.shopping_cart,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => BottomSheetProduct(
                            model: product,
                          ),
                        ).then(
                          (value) {
                            if (value != null) {
                              if (value is ResultDataBottomSheetProduct) {
                                Toast.showText(
                                  'Thêm vào giỏ hàng thành công',
                                  iconData: Icons.shopping_cart,
                                );
                                context
                                    .read<ShoppingCartCubit>()
                                    .onSetQuantityCart(
                                      product: value.product,
                                      quantity: value.total,
                                    );
                                if (value.type == ResultDataType.add) {}
                                if (value.type == ResultDataType.goScreen) {
                                  Navigator.of(context).pushNamed(
                                      AppRouterEndPoint.SHOPPINGCART);
                                }
                              }
                            }
                          },
                        );
                        // Toast.showText(
                        //   Message.addCart,
                        //   iconData: Icons.shopping_cart,
                        // );
                        // shoppingCartCubit.onAddCart(
                        //   product: product,
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<ShoppingCartCubit>().onAddCart(
                      product: product,
                    );
                Navigator.pushNamed(context, AppRouterEndPoint.SHOPPINGCART);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.accentPrimaryColor,
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    Strings.buyNow,
                    style: TextStyleApp.textStyle5.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
