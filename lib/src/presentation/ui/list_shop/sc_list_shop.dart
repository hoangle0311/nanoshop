import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/domain/entities/shop/shop.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../config/styles/app_color.dart';
import '../../../config/styles/app_text_style.dart';
import '../../../core/assets/image_path.dart';
import '../../../core/params/token_param.dart';
import '../../cubits/city_cubit/city_cubit.dart';
import '../../cubits/get_list_shop_cubit/get_list_shop_cubit.dart';
import '../../views/components/drop_down_field/drop_down_field.dart';

class ScListShop extends StatelessWidget {
  const ScListShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<CityCubit>()
            ..onGetListData(
              injector<TokenParam>(),
            ),
        ),
        BlocProvider(
          create: (context) => injector<GetListShopCubit>()
            ..onGetListShop(
              tokenParam: injector<TokenParam>(),
            ),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.grey,
        appBar: PageAppBar(
          title: 'Hệ thống cơ sở',
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: BlocBuilder<CityCubit, CityState>(
                builder: (context, state) {
                  if (state.status == CityStatus.success &&
                      state.listData.isNotEmpty) {
                    return DropDownField(
                      listItem: state.listData,
                      hint: 'Tỉnh/ Thành phố',
                      value: state.city,
                      onChanged: (value) {
                        context.read<GetListShopCubit>().onGetListShop(
                              tokenParam: injector<TokenParam>(),
                              city: value,
                            );
                      },
                    );
                  }

                  return DropDownField(
                    listItem: [],
                    hint: 'Tỉnh/ Thành phố',
                    value: null,
                    onChanged: (value) {},
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: BlocBuilder<GetListShopCubit, GetListShopState>(
                  builder: (context, GetListShopState state) {
                    if (state.shops.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.shops.length,
                        itemBuilder: (context, index) {
                          return _ItemShopList(
                            model: state.shops[index],
                          );
                        },
                      );
                    }

                    if (state.shops.isEmpty &&
                        state.status == GetListShopStatus.loading) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    return Center(
                      child: Text(
                        'Không tìm thấy cửa hàng nào',
                        style: TextStyleApp.textStyle2.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemShopList extends StatelessWidget {
  final Shop model;

  const _ItemShopList({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRouterEndPoint.DETAILSHOP,
            arguments: model,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.white,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 115,
                      child: LoadImageFromUrlWidget(
                        imageUrl: Environment.domain +
                            '/mediacenter/' +
                            (model.avatarPath ?? "") +
                            (model.avatarName ?? ""),
                        height: 115,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name ?? '',
                            style: TextStyleApp.textStyle5.copyWith(
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${model.wardName != null ? model.wardName != "" ? model.wardName.toString() + ', ' : "" : ""}",
                                style: TextStyleApp.textStyle4.copyWith(
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                "${model.districtName != null ? model.districtName != "" ? model.districtName.toString() + ', ' : "" : ""}",
                                style: TextStyleApp.textStyle4.copyWith(
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                "${model.provinceName != null ? model.provinceName != "" ? model.provinceName.toString() + '.' : "" : ""}",
                                style: TextStyleApp.textStyle4.copyWith(
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                model.phone != null
                                    ? model.phone != ""
                                        ? model.phone.toString()
                                        : "Không xác định"
                                    : "Không xác định",
                                style: TextStyleApp.textStyle4.copyWith(
                                  fontSize: 14,
                                  color: AppColors.black,
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
            ),
          ),
        ),
      ),
    );
  }
}
