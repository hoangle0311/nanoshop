import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/core/form_model/login/password_input.dart';
import 'package:nanoshop/src/core/form_model/sign_up/confirm_password_input.dart';
import 'package:nanoshop/src/core/toast/toast.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/remove_focus_widget/remove_focus_widget.dart';

import '../../../config/styles/app_text_style.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/change_password_bloc/change_password_bloc.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';
import '../../views/components/text_field/text_field_input.dart';
import '../../views/dialog/dialog_loading.dart';

class ScChangePassword extends StatelessWidget {
  const ScChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ChangePasswordBloc>(),
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionInProgress) {
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

          if (state.status == FormzStatus.submissionSuccess) {
            Navigator.of(context).pop();
            Toast.showText(state.message);
            Navigator.of(context).pop();
          }

          if (state.status == FormzStatus.submissionFailure) {
            Navigator.of(context).pop();
            Toast.showText("Mật khẩu cũ không chính xác");
          }
        },
        child: RemoveFocusWidget(
          child: Scaffold(
            appBar: const PageAppBar(
              title: 'Đổi mật khẩu',
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                children: const [
                  _TitleInput(
                    title: "Mật khẩu cũ",
                    child: _OldPasswordInputWidget(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _TitleInput(
                    title: "Mật khẩu mới",
                    child: _NewPasswordInputWidget(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _TitleInput(
                    title: "Nhập lại mật khẩu mới",
                    child: _ConfirmPasswordInputWidget(),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const _BottomNav(),
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return BottomNavText(
          title: Strings.send,
          isShowGradient: state.status.isValidated ? true : false,
          onTap: state.status.isValidated
              ? () {
                  context.read<ChangePasswordBloc>().add(
                        ChangePasswordSubmitted(
                          tokenParam: injector<TokenParam>(),
                          userId:
                              injector<AuthenticationBloc>().state.user.userId!,
                        ),
                      );
                }
              : null,
        );
      },
    );
  }
}

class _OldPasswordInputWidget extends StatelessWidget {
  const _OldPasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.oldPassword != current.oldPassword,
      builder: ((context, state) {
        return TextFieldInput(
          // key: const Key('passwordForm_usernameInput_textField'),
          onChanged: (password) => context.read<ChangePasswordBloc>().add(
                OldPasswordChanged(
                  password,
                ),
              ),
          obscureText: true,
          labelText: Strings.labelPassword,
          errorText: state.oldPassword.invalid
              ? state.oldPassword.error!.toText()
              : null,
          iconData: Icons.lock,
        );
      }),
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

class _NewPasswordInputWidget extends StatelessWidget {
  const _NewPasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword,
      builder: ((context, state) {
        return TextFieldInput(
          // key: const Key('passwordForm_usernameInput_textField'),
          onChanged: (password) => context.read<ChangePasswordBloc>().add(
                NewPasswordChanged(
                  password,
                ),
              ),
          obscureText: true,
          labelText: Strings.labelPassword,
          errorText: state.newPassword.invalid
              ? state.newPassword.error!.toText()
              : null,
          iconData: Icons.lock,
        );
      }),
    );
  }
}

class _ConfirmPasswordInputWidget extends StatelessWidget {
  const _ConfirmPasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword ||
          previous.newPassword != current.newPassword,
      builder: ((context, state) {
        return TextFieldInput(
          // key: const Key('confirmPasswordForm_usernameInput_textField'),
          onChanged: (password) => context.read<ChangePasswordBloc>().add(
                ConfirmPasswordChanged(
                  password,
                ),
              ),
          obscureText: true,
          labelText: Strings.labelConfirmPassword,
          errorText: state.confirmPassword.invalid
              ? state.confirmPassword.error!.toText()
              : null,
          iconData: Icons.lock,
        );
      }),
    );
  }
}
