import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/cubits/search_list_product_cubit/search_list_product_cubit.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../config/routers/app_router/app_router.dart';
import '../../../../core/params/filter_param.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String value)? onChanged;

  const SearchAppBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(110);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _showSuffixIcon = false;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onTyping);
    _onTypingStream.debounceTime(const Duration(milliseconds: 400)).listen(
      (event) {
        context.read<SearchListProductCubit>().onGetRelatedList(
              searchKey: event,
            );
      },
    );
  }

  final BehaviorSubject _onTypingStream = BehaviorSubject();

  _onTyping() {
    searchController.text.isNotEmpty
        ? _showSuffixIcon = true
        : _showSuffixIcon = false;
    setState(() {});
    _onTypingStream.add(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            ImagePath.backgroundAppBar,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          // height: preferredSize.height,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Platform.isAndroid
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      child: TextField(
                        autofocus: true,
                        controller: searchController,
                        onChanged: widget.onChanged,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.white,
                          filled: true,
                          focusColor: AppColors.primaryColor,
                          suffixIcon: _showSuffixIcon
                              ? InkWell(
                                  onTap: () {
                                    searchController.clear();
                                    widget.onChanged!('');
                                  },
                                  child: Icon(Icons.close),
                                )
                              : null,
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
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouterEndPoint.FilterProduct)
                          .then(
                        (value) {
                          if (value != null) {
                            if (value is FilterParam) {
                              context
                                  .read<SearchListProductCubit>()
                                  .onGetRelatedList(
                                    searchKey: searchController.text,
                                    filterParam: value,
                                  );
                            }
                          }
                        },
                      );
                    },
                    child: Image.asset(ImagePath.appBarFilterIcon),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
