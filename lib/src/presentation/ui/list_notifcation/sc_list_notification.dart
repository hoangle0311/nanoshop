import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/core/utils/helper/convert_date_from_millisecond.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/domain/entities/notification/notification.dart';
import 'package:nanoshop/src/domain/entities/notification/type_notification.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nanoshop/src/presentation/cubits/get_list_notification_cubit/get_list_notification_cubit.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../core/params/token_param.dart';

class ScListNotification extends StatelessWidget {
  final TypeNotification typeNotification;

  const ScListNotification({
    Key? key,
    required this.typeNotification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<GetListNotificationCubit>()
        ..onGetNotification(
          injector<TokenParam>(),
          context.read<AuthenticationBloc>().state.user.userId!,
          typeNotification.id ?? 0,
        ),
      child: Scaffold(
        appBar: PageAppBar(
          title: typeNotification.name ?? '',
        ),
        body: BlocBuilder<GetListNotificationCubit, GetListNotificationState>(
          builder: (context, state) {
            if (state.notifications.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    state.notifications.length,
                    (index) {
                      if (typeNotification.id == 1) {
                        return _ItemNotiType1(
                          notification: state.notifications[index],
                        );
                      }
                      return _ItemNotiType2(
                        notification: state.notifications[index],
                      );
                    },
                  ),
                ),
              );
            }
            if (state.status == GetListNotificationStatus.loading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            return Center(
              child: Text(
                'Hiện chưa có thông báo nào',
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

class _ItemNotiType1 extends StatelessWidget {
  final Notifications notification;

  const _ItemNotiType1({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(Environment.domain + (notification.link ?? '')));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Khuyến mãi :',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      notification.title ?? '',
                      textAlign: TextAlign.end,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mô tả :',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      notification.description ?? '',
                      textAlign: TextAlign.end,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ngày bắt đầu :',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      convertDateFromMilliseconds(
                        notification.updatedAt ?? '',
                      ),
                      textAlign: TextAlign.end,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemNotiType2 extends StatelessWidget {
  final Notifications notification;

  const _ItemNotiType2({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(Environment.domain + (notification.link ?? '')));
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mã :',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      notification.id ?? '',
                      textAlign: TextAlign.end,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tiêu đề :',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      notification.title ?? '',
                      textAlign: TextAlign.end,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mô tả :',
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      notification.description ?? '',
                      textAlign: TextAlign.end,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
