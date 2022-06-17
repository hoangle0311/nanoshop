import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';
import 'package:nanoshop/src/data/repositories/auth_repository_impl.dart';
import 'package:nanoshop/src/presentation/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:nanoshop/src/presentation/views/components/icon/icon_with_text.dart';
import 'package:nanoshop/src/presentation/views/dialog/custom_dialog_with_icon.dart';

import '../../../config/styles/app_text_style.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/toast/toast.dart';
import '../../../domain/entities/user_login/user_login.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                ImagePath.backgroundAccountPage,
                width: double.infinity,
                fit: BoxFit.fill,
                height: size.height * 0.5,
              ),
            ),
            Positioned(
              top: size.height * 0.4,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor("#F5F5F5"),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            if (state.status == AuthenticationStatus.authenticated)
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: AccountFragment(
                  user: state.user,
                ),
              ),
            if (state.status == AuthenticationStatus.authenticating)
              const Center(
                child: CupertinoActivityIndicator(),
              ),
          ],
        );
      },
    );
  }
}

class AccountFragment extends StatelessWidget {
  final UserLogin user;

  const AccountFragment({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              InformationHeader(
                user: user,
              ),
              const SizedBox(
                height: 15,
              ),
              const UserConfigWidget(),
              const SizedBox(
                height: 15,
              ),
              const UserConfigWidget2(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserConfigWidget extends StatelessWidget {
  const UserConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ItemConfig(
            onTap: (){
              Navigator.of(context).pushNamed(AppRouterEndPoint.UPDATEINFORMATION);
            },
            title: Strings.labelAccountPageConfig,
            pathIcons: ImagePath.accountPageIconUser,
          ),
          ItemConfig(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouterEndPoint.LISTORDER);
            },
            title: Strings.labelOrderPageConfig,
            pathIcons: ImagePath.accountPageIconFile,
          ),
          ItemConfig(
            title: Strings.labelWalletPageConfig,
            pathIcons: ImagePath.accountPageIconWallet,
            hasBorder: false,
          ),
        ],
      ),
    );
  }
}

class UserConfigWidget2 extends StatelessWidget {
  const UserConfigWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ItemConfig(
            title: Strings.labelAQPageConfig,
            pathIcons: ImagePath.accountPageIconHelp,
          ),
          ItemConfig(
            onTap: (){
              Navigator.of(context).pushNamed(AppRouterEndPoint.CHANGEPASSWORD);
            },
            title: Strings.labelChangePasswordPageConfig,
            pathIcons: ImagePath.accountPageIconUnlock,
          ),
          ItemConfig(
            onTap: () async {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const Dialog(
                  child: CustomDialogWithIcon(
                    assetsSource: ImagePath.accountPageIconLogout,
                    title: Message.logOutAccount,
                  ),
                ),
              ).then(
                (value) {
                  if (value) {
                    context.read<AuthenticationBloc>().add(
                          AuthenticationLogoutRequested(),
                        );
                    Toast.showText(
                      Message.logOutSuccess,
                      iconData: Icons.person,
                    );
                    context.read<BottomNavCubit>().onTapBottomNav(0);
                  }
                },
              );
            },
            title: Strings.labelLogoutPageConfig,
            pathIcons: ImagePath.accountPageIconLogout,
            hasBorder: false,
          ),
        ],
      ),
    );
  }
}

class ItemConfig extends StatelessWidget {
  final String title;
  final String pathIcons;
  final bool hasBorder;
  final Function()? onTap;

  const ItemConfig({
    Key? key,
    required this.title,
    required this.pathIcons,
    this.hasBorder = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              pathIcons,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: hasBorder
                      ? Border(
                          bottom: BorderSide(
                            color: HexColor('#F2F2F2'),
                          ),
                        )
                      : null,
                ),
                child: Text(
                  title,
                  style: TextStyleApp.textStyle4.copyWith(
                    color: HexColor('#4F4F4F'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InformationHeader extends StatelessWidget {
  final UserLogin user;
  final Function()? onTap;

  const InformationHeader({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 5,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    Environment.domain +
                        (user.avatarPath ?? '') +
                        (user.avatarName ?? ''),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: AppColors.dividerColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  user.name ?? '',
                  style: TextStyleApp.textStyle1.copyWith(
                    color: AppColors.white,
                  ),
                ),
                IconWithText(
                  iconData: Icons.phone,
                  title: user.phone ?? '',
                ),
                IconWithText(
                  iconData: Icons.email_outlined,
                  title: user.email != null && user.email != ""
                      ? user.email!
                      : "Không xác định",
                ),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
