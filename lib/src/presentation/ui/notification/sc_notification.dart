import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routers/app_router/app_router.dart';
import '../../../config/styles/app_color.dart';
import '../../../config/styles/app_text_style.dart';
import '../../../core/assets/image_path.dart';
import '../../../core/params/token_param.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../injector.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../cubits/get_type_notification/get_type_notification_cubit.dart';
import '../../pages/notification_page/notification_page.dart';
import '../../views/components/app_bar/main_app_bar.dart';

class ScNotification extends StatelessWidget {
  const ScNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: 'Thông báo',
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            context.read<GetTypeNotificationCubit>().onGetType(
              state.user.userId!,
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<GetTypeNotificationCubit, GetTypeNotificationState>(
                builder: (context, state) {
                  // Log.i("state.toString()");
                  // Log.i(state.toString());
                  if (state.listType.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        state.listType.length,
                            (index) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRouterEndPoint.LISTNOTIFICATION,
                              arguments: state.listType[index],
                            );
                          },
                          child: NotificationItem(
                            url: ImagePath.updateIconNotificationScreen,
                            sub: state.listType[index].name ?? '',
                            title: state.listType[index].name ?? '',
                            count: 0,
                          ),
                        ),
                      ),
                    );
                  }

                  return Center(
                    child: Text(
                      'Danh sách trống',
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  );
                },
              ),
              // NotificationItem(
              //   url: ImagePath.updateIconNotificationScreen,
              //   sub: "Cập nhật TATRA Pharmacy",
              //   title: "Cập nhật",
              //   count: 50,
              // ),
              // NotificationItem(
              //   url: ImagePath.voucherIconNotificationScreen,
              //   sub: "Voucher",
              //   title: "Voucher",
              //   count: 50,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
