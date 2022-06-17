import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../config/styles/app_color.dart';
import '../../../config/styles/app_text_style.dart';
import '../../../core/data/menu_data/menu_data.dart';
import '../../../core/utils/log/log.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../views/components/dash/dash.dart';

class ScMenu extends StatelessWidget {
  const ScMenu({
    Key? key,
  }) : super(key: key);

  checkSize(Size size) {
    double a = size.width / 150;
    double b = a - a.floor();
    int count = 2;
    if (b > 0.75) {
      count = a.round();
    } else {
      count = a.floor();
    }
    return count;
  }

  Widget _itemMenu({
    dynamic model,
    required BuildContext context,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 10,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 25,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            model.url,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            model.name,
            style: TextStyleApp.textStyle2.copyWith(
              color: AppColors.primaryColor,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Dash(
            color: AppColors.primaryColor,
          ),
          SizedBox(
            height: 15,
          ),
          // RichText(
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: "33",
          //         style: TextStyleApp.textStyle1.copyWith(
          //           fontSize: 15,
          //           color: AppColor.color17,
          //         ),
          //       ),
          //       TextSpan(
          //         text: " thông báo mới",
          //         style: TextStyleApp.textStyle2.copyWith(
          //           color: AppColor.color13,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: 'Menu',
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRouterEndPoint.SEARCHPRODUCT);
              },
              readOnly: true,
              decoration: InputDecoration(
                hintStyle: TextStyleApp.textStyle2.copyWith(
                  color: AppColors.primaryColor,
                ),
                hintText: "Từ khóa tìm kiếm...",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5),
                ),
                suffixIcon: Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                direction: Axis.horizontal,
                runSpacing: 10,
                alignment: WrapAlignment.spaceBetween,
                spacing: 10,
                children: [
                  ...List.generate(
                    dummyMenu.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          var authBloc = context.read<AuthenticationBloc>();
                          var authState = authBloc.state;

                          if (dummyMenu[index].name == "Đơn hàng") {
                            if (authState.user != UserLogin.empty) {
                              Navigator.of(context)
                                  .pushNamed(AppRouterEndPoint.LISTORDER);
                            } else {
                              Navigator.of(context)
                                  .pushNamed(AppRouterEndPoint.LOGIN);
                            }
                          }

                          if (dummyMenu[index].name == "Thông báo") {
                            if (authState.user != UserLogin.empty) {
                              Navigator.of(context)
                                  .pushNamed(AppRouterEndPoint.NOTIFICATION);
                            } else {
                              Navigator.of(context)
                                  .pushNamed(AppRouterEndPoint.LOGIN);
                            }
                          }
                        },
                        child: _itemMenu(
                          model: dummyMenu[index],
                          context: context,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: GridView(
          //     shrinkWrap: true,
          //     padding: EdgeInsets.all(15),
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: checkSize(size),
          //       crossAxisSpacing: 20,
          //       mainAxisSpacing: 20,
          //       mainAxisExtent: 180,
          //     ),
          //     children: dummyMenu
          //         .map(
          //           (e) => _itemMenu(
          //             model: e,
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
