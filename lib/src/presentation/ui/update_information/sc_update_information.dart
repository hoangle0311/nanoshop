import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/remove_focus_widget/remove_focus_widget.dart';

import '../../../config/styles/app_color.dart';
import '../../../config/styles/app_text_style.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../../core/toast/toast.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';
import '../../views/components/text_field/text_field_input.dart';
import '../../views/components/text_field/text_field_input_with_inital_text.dart';
import '../../views/dialog/dialog_loading.dart';

class ScUpdateInformation extends StatelessWidget {
  const ScUpdateInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => injector<UpdateUserCubit>(),
      child: BlocConsumer<UpdateUserCubit, UpdateUserState>(
        listener: (context, state) {
          if (state.status == UpdateUserStatus.loading) {
            showDialog(
              context: context,
              builder: (context) {
                return const Dialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: DialogLoading(),
                );
              },
            );
          }
          if (state.status == UpdateUserStatus.success) {
            Navigator.of(context).pop();
            context.read<AuthenticationBloc>().add(AuthenticationUserRequest(
                  tokenParam: injector<TokenParam>(),
                  userId: context.read<AuthenticationBloc>().state.user.userId!,
                ));
            Toast.showText(state.message);
            Navigator.of(context).pop();
          }

          if (state.status == UpdateUserStatus.fail) {
            Navigator.of(context).pop();
            Toast.showText(state.message);
          }
        },
        builder: (context, state) {
          return RemoveFocusWidget(
            child: Scaffold(
              appBar: const PageAppBar(
                title: "Thông tin cá nhân",
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      _TitleInput(
                        title: "Họ và tên",
                        child: _UpdateNameInputWidget(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _TitleInput(
                        title: "Email",
                        child: _EmailInputWidget(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _TitleInput(
                        title: "Địa chỉ",
                        child: _AddressInputWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: _BottomNav(),
            ),
          );
        },
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateUserCubit, UpdateUserState>(
  builder: (context, state) {
    return BottomNavText(
      title: Strings.update,
      onTap: () {
        context.read<UpdateUserCubit>().updateUser(
          tokenParam: injector<TokenParam>(),
          userId: injector<AuthenticationBloc>()
              .state
              .user
              .userId!,
          name: state.userName,
          email: state.email,
          address: state.address,
        );
      },
    );
  },
);
  }
}

class _TitleInput extends StatelessWidget {
  final Widget child;
  final String title;

  const _TitleInput({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyleApp.textStyle2.copyWith(
            color: AppColors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        child,
      ],
    );
  }
}

class _UpdateNameInputWidget extends StatelessWidget {
  const _UpdateNameInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return TextFieldInputWithInitialText(
          key: const Key('passwordForm_usernameInput_textField'),

          labelText: Strings.labelPassword,
          initialText: state.user.name,
          onChanged: context.read<UpdateUserCubit>().onChangeUserName,
          // errorText: state.newPassword.invalid
          //     ? state.newPassword.error!.toText()
          //     : null,
          iconData: Icons.person,
        );
      },
    );
  }
}

class _EmailInputWidget extends StatelessWidget {
  const _EmailInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return TextFieldInputWithInitialText(
          labelText: Strings.labelPassword,
          initialText: state.user.email,
          onChanged: context.read<UpdateUserCubit>().onChangeEmail,
          // errorText: state.newPassword.invalid
          //     ? state.newPassword.error!.toText()
          //     : null,
          iconData: Icons.person,
        );
      },
    );
  }
}

class _AddressInputWidget extends StatelessWidget {
  const _AddressInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return TextFieldInputWithInitialText(
          labelText: Strings.labelPassword,
          initialText: state.user.address,
          onChanged: context.read<UpdateUserCubit>().onChangeAddress,
          // errorText: state.newPassword.invalid
          //     ? state.newPassword.error!.toText()
          //     : null,
          iconData: Icons.person,
        );
      },
    );
  }
}
