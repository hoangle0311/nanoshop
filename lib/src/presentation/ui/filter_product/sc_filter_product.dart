import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/params/filter_param.dart';
import 'package:nanoshop/src/core/utils/helper/convert_price.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../../core/utils/log/log.dart';
import '../../cubits/manufacturer_cubit/manufacturer_cubit.dart';
import '../../cubits/range_cubit/range_cubit.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';

class ScFilterProduct extends StatelessWidget {
  const ScFilterProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<RangeCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<ManufacturerCubit>()
            ..getListManufacturer(
              injector<TokenParam>().token,
            ),
        ),
      ],
      child: Scaffold(
        appBar: PageAppBar(
          title: 'Lọc tìm kiếm',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _PriceWidget(),
              _ManufactureWidget(),
            ],
          ),
        ),
        bottomNavigationBar: Builder(builder: (context) {
          return BottomNavText(
            onTap: () {
              Navigator.of(context).pop(
                FilterParam(
                  manufacturer: context.read<ManufacturerCubit>().state.manufacturer,
                  values: context.read<RangeCubit>().state.rangeValues,
                ),
              );
            },
            title: Strings.apply,
          );
        }),
      ),
    );
  }
}

class _PriceWidget extends StatelessWidget {
  final RangeValues currentRangeValues = const RangeValues(0, 500000000);

  const _PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RangeCubit, RangeState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  "Giá",
                  style: TextStyleApp.textStyle1.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          convertPrice(state.rangeValues.start),
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.grey, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          convertPrice(state.rangeValues.end),
                          style: TextStyleApp.textStyle1.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RangeSlider(
                // Giá trị thay đổi
                values: state.rangeValues,
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.grey,
                min: 100000,
                max: 100000000,
                onChanged: (RangeValues values) {
                  context.read<RangeCubit>().onChangeRangValue(values);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "min".toUpperCase(),
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "max".toUpperCase(),
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 5,
                width: double.infinity,
                color: AppColors.grey,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ManufactureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManufacturerCubit, ManufacturerState>(
      builder: (context, state) {
        if (state.listManufacturer.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Thương hiệu",
                    style: TextStyleApp.textStyle1.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                GridViewCustom(
                    itemCount: state.listManufacturer.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    mainAxisExtent: 50,
                    maxWight: 120,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<ManufacturerCubit>()
                              .setManufacture(state.listManufacturer[index]);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: state.manufacturer ==
                                    state.listManufacturer[index]
                                ? AppColors.primaryColor
                                : AppColors.grey,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: state.manufacturer ==
                                      state.listManufacturer[index]
                                  ? AppColors.white
                                  : AppColors.grey,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Text(
                            state.listManufacturer[index].name ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyleApp.textStyle1.copyWith(
                              color: state.manufacturer ==
                                      state.listManufacturer[index]
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 15,
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

class GridViewCustom extends StatelessWidget {
  bool shrinkWrap;
  ScrollPhysics? physics;
  int itemCount;
  IndexedWidgetBuilder itemBuilder;
  double mainAxisExtent;
  double maxWight;
  double crossAxisSpacing;
  double mainAxisSpacing;
  EdgeInsetsGeometry? padding;
  ScrollController? controller;
  Axis scrollDirection;

  GridViewCustom({
    this.physics,
    this.shrinkWrap = false,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.mainAxisExtent = 100,
    this.maxWight = 150,
    this.padding,
    this.controller,
    this.scrollDirection = Axis.vertical,
  });

  checkSize(Size size) {
    double a = size.width / maxWight;
    double b = a - a.floor();
    int count = 2;
    if (b > 0.75) {
      count = a.round();
    } else {
      count = a.floor();
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    checkSize(size);
    return GridView.builder(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      padding: padding,
      scrollDirection: scrollDirection,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: checkSize(size),
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
