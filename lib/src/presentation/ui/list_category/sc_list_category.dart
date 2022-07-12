import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/constant/db_key/shared_paths.dart';
import 'package:nanoshop/src/presentation/ui/list_product/sc_list_product.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/styles/app_color.dart';
import '../../../injector.dart';
import '../../blocs/blocs.dart';
import '../../views/components/app_bar/main_app_bar.dart';
import '../../views/components/dash/dash.dart';
import '../../views/components/expanded_section/expanded_section.dart';

class ScListCategory extends StatelessWidget {
  const ScListCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<GetCategoryBloc>()
        ..add(
          GetListCategoryEvent(),
        ),
      child: Scaffold(
        appBar: const PageAppBar(
          title: "Danh mục sản phẩm",
        ),
        body: BlocBuilder<GetCategoryBloc, GetCategoryState>(
          builder: (context, state) {
            if (state is GetCategoryDone) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    state.categories.length,
                    (index) => ItemCategory(
                      model: state.categories[index],
                    ),
                  ),
                  // children: (arguments.categories as List)
                  //     .map(
                  //       (e) => ItemCategory(
                  //         model: e,
                  //       ),
                  //     )
                  //     .toList(),
                ),
              );
            }

            if (state is GetCategoryLoading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            return Center(
              child: Text(
                'Danh mục trống',
                style: TextStyleApp.textStyle1.copyWith(
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

class ItemCategory extends StatefulWidget {
  final dynamic model;

  const ItemCategory({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  bool _showChildren = false;

  Future<String> _getCount(
    String categoryId,
  ) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          Environment.domain + '/api/home/getCountInCategory',
        ),
        headers: {
          "Content-Type": "application/json",
          "token":
              injector<SharedPreferences>().getString(SharedPaths.token) ?? '',
        },
        body: json.encode({
          "category_id": categoryId,
          "type": "product",
        }),
      );

      return json.decode(utf8.decode(response.bodyBytes))['data']['count'];
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 5,
            color: AppColors.dividerColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.dividerColor,
                    shape: BoxShape.circle,
                  ),
                  width: 57,
                  height: 57,
                ),
              ),
              Center(
                child: Container(
                  width: 57,
                  height: 57,
                  child: Container(
                    child: LoadImageFromUrlWidget(
                      imageUrl: Environment.domain +
                          "/mediacenter/" +
                          (widget.model.imagePath ?? '') +
                          (widget.model.imageName ?? ''),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRouterEndPoint.LISTPRODUCT,
                      arguments: ScListProductArgument(
                        title: widget.model.catName ?? '',
                        categoryId: widget.model.catId,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.model.catName.toString().toUpperCase(),
                            style: TextStyleApp.textStyle1.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _showChildren = !_showChildren;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _showChildren
                                  ? AppColors.dividerColor.withOpacity(0.2)
                                  : AppColors.dividerColor.withOpacity(0.2),
                            ),
                            child: Icon(
                              _showChildren
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right,
                              color: _showChildren
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ExpandedSection(
                  isSelected: _showChildren,
                  child: Column(
                    children: [
                      Dash(
                        color: AppColors.primaryColor.withOpacity(0.3),
                      ),
                      if (widget.model.children != null)
                        ...List.generate(
                          widget.model.children.length,
                          (index) => InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRouterEndPoint.LISTPRODUCT,
                                arguments: ScListProductArgument(
                                  title: widget.model.children[index].catName ??
                                      '',
                                  categoryId:
                                      widget.model.children[index].catId,
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.model.children[index].catName,
                                    style: TextStyleApp.textStyle2.copyWith(
                                      color: AppColors.black,
                                    ),
                                  ),
                                  FutureBuilder<String>(
                                    future: _getCount(
                                        widget.model.children[index].catId),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          "(${snapshot.data})",
                                          style:
                                              TextStyleApp.textStyle2.copyWith(
                                            color: AppColors.black,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        );
                                      }
                                      return Text(
                                        "(0)",
                                        style: TextStyleApp.textStyle2.copyWith(
                                          color: AppColors.black,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
