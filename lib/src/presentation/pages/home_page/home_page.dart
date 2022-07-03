import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';

import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/domain/entities/flash_sale/flash_sale.dart';

import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/blocs/flash_sale_bloc/flash_sale_bloc.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'package:nanoshop/src/presentation/views/components/banner_widget/slide_banner_home.dart';
import 'package:nanoshop/src/presentation/views/components/buttons/button_with_title_widget.dart';
import 'package:nanoshop/src/presentation/views/components/loading_widget/banner_loading.dart';
import 'package:nanoshop/src/presentation/views/components/loading_widget/list_horizontal_category_loading.dart';
import 'package:nanoshop/src/presentation/views/components/product_widget/list_vertical_product_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../chat/list_chat.dart';
import '../../../chat/models/data_model.dart';
import '../../../chat/screen_chat.dart';
import '../../../config/styles/app_text_style.dart';
import '../../../core/hooks/go_to_list_product_screen.dart';
import '../../../core/params/token_param.dart';
import '../../../domain/entities/user_login/user_login.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/blocs.dart';
import '../../blocs/local_product_bloc/local_product_bloc.dart';
import '../../cubits/time_cubit/time_cubit.dart';
import '../../views/components/category_widget/list_horizontal_categories_widget.dart';
import '../../views/components/product_widget/list_flash_sale_widget.dart';
import '../../views/components/product_widget/list_horizontal_product_widget.dart';
import '../../views/components/widgets/home_title_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Lay banner voi group bang 15350
  static const _groupIdBanner = '15273';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: true,
          create: (_) => injector<GetBannerBloc>()
            ..add(
              GetBannerByGroupId(
                groupId: _groupIdBanner,
                tokenParam: injector<TokenParam>(),
              ),
            ),
        ),
        BlocProvider(
          lazy: true,
          create: (_) => injector<GetCategoryBloc>()
            ..add(
              GetListCategoryEvent(
                tokenParam: injector<TokenParam>(),
              ),
            ),
        ),
        BlocProvider(
          create: (_) => injector<LocalProductBloc>()
            ..add(
              GetListFavouriteProductEvent(),
            ),
        ),
      ],
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  ImagePath.backgroundHomeAppbar,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200,
                  scale: 1,
                ),
                // Image.asset(
                //   ImagePath.backgroundImage,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
              ],
            ),
          ),
          Builder(builder: (context) {
            return _body(context);
          }),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        const HomeAppBar(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<FlashSaleBloc>()
                  .add(GetFlashSale(tokenParam: injector<TokenParam>()));
              context.read<GetBannerBloc>().add(
                GetBannerByGroupId(
                  groupId: _groupIdBanner,
                  tokenParam: injector<TokenParam>(),
                ),
              );
              context.read<GetCategoryBloc>().add(
                GetListCategoryEvent(
                  tokenParam: injector<TokenParam>(),
                ),
              );
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _slideBanner(),
                  const SizedBox(
                    height: 10,
                  ),
                  _horizontalCategory(),
                  const SizedBox(
                    height: 10,
                  ),
                  const FlashSaleWidget(),
                  // BlocProvider(
                  //   create: (context) => injector<ProductBloc>()
                  //     ..add(
                  //       GetListProductEvent(),
                  //     ),
                  //   child: const HorizontalListProductHomePage(),
                  // ),
                  // Banner Home
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 10,
                  //   ),
                  //   child: const Placeholder(
                  //     fallbackWidth: double.infinity,
                  //     fallbackHeight: 120,
                  //   ),
                  // ),
                  BlocProvider(
                    create: (context) => injector<ProductBloc>()
                      ..add(
                        GetListProductEvent(
                          tokenParam: injector<TokenParam>(),
                        ),
                      ),
                    child: const VerticalListProductHomePage(),
                  ),
                  // _verticalListProductFavourite(),
                  // ShopsWidget(),
                 const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _verticalListProductFavourite() {
    return BlocConsumer<LocalProductBloc, LocalProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LocalProductDone) {
          if (state.products.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const HomeTitleContainer(
                    title: "Sản phẩm yêu thích",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListVerticalProductWidget(products: state.products),
                const SizedBox(
                  height: 10,
                ),
                ButtonWithTitleWidget(
                  onTap: () {},
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.yellow,
                    ],
                  ),
                ),
              ],
            );
          }

          return Container();
        }

        return Container();
      },
    );
  }

  Widget _slideBanner() {
    return BlocBuilder<GetBannerBloc, GetBannerState>(
      builder: (context, state) {
        if (state is GetBannerDone) {
          if (state.banners.isNotEmpty) {
            return SlideBannerHome(
              banners: state.banners,
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

  Widget _horizontalCategory() {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategoryDone) {
          if (state.categories.isNotEmpty) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: HomeTitleContainer(
                    title: "Danh mục",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouterEndPoint.LISTCATEGORY);
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListHorizontalCategoriesWidget(
                  categories: state.categories,
                ),
              ],
            );
          }

          return Container();
        }
        if (state is GetCategoryFailed) {
          return Container();
        }

        return const ListHorizontalCategoryLoading();
      },
    );
  }
}

class HorizontalListProductHomePage extends StatelessWidget {
  const HorizontalListProductHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return const ListHorizontalCategoryLoading();
        }

        if (state.products.isNotEmpty) {
          return BlocListener<LocalProductBloc, LocalProductState>(
            listener: (_, localState) {
              if (localState is LocalProductDone) {
                if (localState.addProduct != null) {
                  BlocProvider.of<ProductBloc>(context).add(
                    CheckAddFavouriteProductEvent(
                      product: localState.addProduct!,
                    ),
                  );
                }
                if (localState.removeProduct != null) {
                  BlocProvider.of<ProductBloc>(context).add(
                    CheckRemoveFavouriteProductEvent(
                      product: localState.removeProduct!,
                    ),
                  );
                }
              }
            },
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: HomeTitleContainer(
                      title: "Danh mục",
                      titleColor: AppColors.primaryColor,
                      onTap: () {
                        goToListProductScreen(
                          context: context,
                          title: "Danh mục",
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListHorizontalProductWidget(products: state.products),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}

class VerticalListProductHomePage extends StatelessWidget {
  const VerticalListProductHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return const ListHorizontalCategoryLoading();
        }

        if (state.products.isNotEmpty) {
          return BlocListener<LocalProductBloc, LocalProductState>(
            listener: (_, localState) {
              if (localState is LocalProductDone) {
                if (localState.addProduct != null) {
                  BlocProvider.of<ProductBloc>(context).add(
                    CheckAddFavouriteProductEvent(
                      product: localState.addProduct!,
                    ),
                  );
                }
                if (localState.removeProduct != null) {
                  BlocProvider.of<ProductBloc>(context).add(
                    CheckRemoveFavouriteProductEvent(
                      product: localState.removeProduct!,
                    ),
                  );
                }
              }
            },
            child: Container(
              color: AppColors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: HomeTitleContainer(
                      title: "Tất cả sản phẩm",
                      titleColor: AppColors.black,
                      onTap: () {
                        goToListProductScreen(
                          context: context,
                          title: "Tất cả sản phẩm",
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListVerticalProductWidget(products: state.products),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWithTitleWidget(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.yellow,
                      ],
                    ),
                    onTap: () {
                      goToListProductScreen(
                        context: context,
                        title: "Tất cả sản phẩm",
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        }

        return Container();
      },
      listener: (context, state) {},
    );
  }
}

class ShopsWidget extends StatelessWidget {
  const ShopsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Image.asset(
            ImagePath.chiNhanhImage,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Positioned(
            top: 80,
            left: 10,
            child: IntrinsicWidth(
              child: Column(
                children: [
                  Text(
                    "Hệ thống cơ sở",
                    style: TextStyleApp.textStyle7.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouterEndPoint.LISTSHOP);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.yellow,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Xem chi tiết",
                        style: TextStyleApp.textStyle7.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: preferredSize.height,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRouterEndPoint.MENU,
                );
              },
              child: Image.asset(ImagePath.appBarIconMenu),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRouterEndPoint.SEARCHPRODUCT);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Tìm kiếm...',
                            style: TextStyleApp.textStyle2.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          child: Image.asset(ImagePath.appBarIconSearch),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
              buildWhen: (pre, cur) {
                return pre.listCart != cur.listCart;
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRouterEndPoint.SHOPPINGCART,
                    );
                  },
                  child: Badge(
                    showBadge: state.listCart.isNotEmpty,
                    badgeContent: Text(
                      state.listCart.length.toString(),
                      style: TextStyleApp.textStyle1.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    badgeColor: Colors.white,
                    animationDuration: Duration.zero,
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      ImagePath.appBarShoppingBagIcon,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () async {
                var authBloc = context.read<AuthenticationBloc>();
                var authState = authBloc.state;

                if (authState.user != UserLogin.empty) {
                  DataModel dataModel = DataModel(authState.user.userId);
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  context.read<AuthenticationBloc>().add(
                    RemoveCountMessageLocal(),
                  );
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
                  Navigator.of(context).pushNamed(AppRouterEndPoint.LOGIN);
                }
              },
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return Badge(
                    showBadge: state.countMessage > 0,
                    badgeContent: Text(
                      state.countMessage.toString(),
                      style: TextStyleApp.textStyle1.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    badgeColor: Colors.white,
                    animationDuration: Duration.zero,
                    child: Image.asset(ImagePath.appBarMessageIcon),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashSaleBloc, FlashSaleState>(
      builder: (context, state) {
        if (state.status == FlashSaleStatus.running &&
            state.flashSale.isNotEmpty) {
          return Column(
            children: List.generate(
              state.flashSale.length,
                  (index) {
                return Container(
                  height: 360,
                  width: double.infinity,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      // Positioned(
                      //   top: 0,
                      //   left: 0,
                      //   right: 0,
                      //   bottom: 0,
                      //   child: Image.asset(
                      //     ImagePath.flashSaleBackground,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: TimeFlashSaleWidget(
                          flashSale: state.flashSale[index],
                        ),
                      ),
                      Positioned(
                        top: 90,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Column(
                          children: [
                            ListFlashSaleWidget(
                              products: state.flashSale[index].products!,
                            ),
                            // Expanded(
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: List.generate(
                            //       state.listProduct.length,
                            //       (index) {
                            //         return IndicatorPageView(
                            //           height: 4,
                            //           isActive: _currentIndex == index ? true : false,
                            //           onTap: () {
                            //             // if (_indexPage != index) {
                            //             //   // _pageController.animateToPage(index,
                            //             //   //     duration: Duration(milliseconds: 1000),
                            //             //   //     curve: Curves.fastOutSlowIn);
                            //             // }
                            //           },
                            //         );
                            //       },
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRouterEndPoint.DETAILFLASHSALE,
                                arguments: state.flashSale[index],
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primaryColor,
                                    Colors.red,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Xem thêm",
                                style: TextStyleApp.textStyle7.copyWith(
                                  color: Colors.white,
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
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}

class TimeFlashSaleWidget extends StatelessWidget {
  final FlashSale flashSale;

  const TimeFlashSaleWidget({
    Key? key,
    required this.flashSale,
  }) : super(key: key);

  Widget _timeDeco({required int time}) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primaryColor,
            AppColors.yellow,
          ],
        ).createShader(bounds);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          time > 9 ? time.toString() : "0" + time.toString(),
          style: TextStyleApp.textStyle2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    Duration duration = Duration(
      milliseconds: (int.parse(flashSale.enddate ?? '0') * 1000 -
          (dateTime.millisecondsSinceEpoch)),
    );

    // TODO: Xóa flashsale khi complete
    return BlocBuilder<TimeCubit, TimeState>(
      bloc: injector<TimeCubit>()..running(totalTime: duration.inSeconds),
      builder: (context, state) {
        if (state.status == TimeStatus.running) {
          Duration runningTime = Duration(
            seconds: state.time,
          );

          return Container(
            height: 65,
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  height: 65,
                  width: double.infinity,
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  child: Image.asset(
                    ImagePath.flashSaleDecor2,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 65,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    height: 20,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 15,
                  right: 15,
                  child: Image.asset(
                    ImagePath.flashSaleDecor,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.flashSaleText),
                      SizedBox(
                        width: 20,
                      ),
                      if (runningTime.inDays > 0)
                        Row(
                          children: [
                            _timeDeco(
                              time: runningTime.inDays,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              ":",
                              style: TextStyleApp.textStyle2.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          _timeDeco(
                            time: runningTime.inHours.remainder(24),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            ":",
                            style: TextStyleApp.textStyle2.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _timeDeco(
                            time: runningTime.inMinutes.remainder(60),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            ":",
                            style: TextStyleApp.textStyle2.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _timeDeco(
                            time: runningTime.inSeconds.remainder(60),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   top: 0,
                //   bottom: 0,
                //   left: 20,
                //   right: 20,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(vertical: 10),
                //     decoration: BoxDecoration(
                //       color: AppColor.color5,
                //       borderRadius: BorderRadius.circular(50),
                //       border: Border.all(
                //         color: AppColor.color9,
                //         width: 10,
                //       ),
                //     ),
                //     child: Center(
                //       child: Text(
                //         'Sản phẩm mới'.toUpperCase(),
                //         style: TextStyleApp.textStyle5,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}