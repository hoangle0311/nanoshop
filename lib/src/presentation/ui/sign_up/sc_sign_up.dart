import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/core/form_model/login/password_input.dart';
import 'package:nanoshop/src/core/form_model/login/username_input.dart';
import 'package:nanoshop/src/core/form_model/sign_up/confirm_password_input.dart';
import 'package:nanoshop/src/core/form_model/sign_up/fullname_input.dart';
import 'package:nanoshop/src/presentation/views/components/icon/icons_back.dart';
import 'package:nanoshop/src/presentation/views/components/remove_focus_widget/remove_focus_widget.dart';

import '../../../config/styles/app_text_style.dart';
import '../../../core/assets/image_path.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../../core/toast/toast.dart';
import '../../../injector.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../../views/components/buttons/button_loading.dart';
import '../../views/components/buttons/button_with_center_title.dart';
import '../../views/components/check_box/circle_check_box.dart';
import '../../views/components/text/title_form.dart';
import '../../views/components/text_field/text_field_with_icon.dart';

class ScSignUp extends StatelessWidget {
  const ScSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<SignUpBloc>(),
      child: RemoveFocusWidget(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  ImagePath.backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              const SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Toast.showText(
            state.message,
            iconData: Icons.favorite,
          );
          Navigator.of(context).pop(true);
        }
        if (state.status == FormzStatus.submissionFailure) {
          Toast.showText(
            state.message,
            iconData: Icons.sms_failed,
          );
        }
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    alignment: Alignment.centerLeft,
                    child: IconsBack(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: size.width / 3,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            ImagePath.appIcon,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      TitleForm(
                        title: Strings.titleSignUp,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _UsernameInputWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      _FullNameInputWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      _PasswordInputWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      _ConfirmPasswordInputWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _ConfirmPolicyWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _SignUpButton(),
                    ],
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

class _ConfirmPolicyWidget extends StatelessWidget {
  const _ConfirmPolicyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.policy != current.policy,
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                context.read<SignUpBloc>().add(
                      SignUpPolicyChanged(
                        !state.policy.value,
                      ),
                    );
              },
              child: CircleCheckBox(
                isSelected: state.policy.value,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Đồng ý ",
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.dividerColor,
                    ),
                  ),
                  TextSpan(
                    text: "điều khoản & chính sách ",
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.dividerColor,
                    ),
                  ),
                  TextSpan(
                    text: "của Nanoshop.",
                    style: TextStyleApp.textStyle2.copyWith(
                      color: AppColors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _UsernameInputWidget extends StatelessWidget {
  const _UsernameInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: ((context, state) {
        return TextFieldWithIcon(
          key: const Key('signUpForm_usernameInput_textField'),
          onChanged: (username) => context.read<SignUpBloc>().add(
                SignUpUsernameChanged(
                  username,
                ),
              ),
          labelText: Strings.labelAccount,
          errorText:
              state.username.invalid ? state.username.error!.toText() : null,
          iconData: Icons.phone,
        );
      }),
    );
  }
}

class _FullNameInputWidget extends StatelessWidget {
  const _FullNameInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.fullname != current.fullname,
      builder: ((context, state) {
        return TextFieldWithIcon(
          key: const Key('fullNameForm_usernameInput_textField'),
          onChanged: (fullname) => context.read<SignUpBloc>().add(
                SignUpFullNameChanged(
                  fullname,
                ),
              ),
          labelText: Strings.labelFullname,
          errorText:
              state.fullname.invalid ? state.fullname.error!.toText() : null,
          iconData: Icons.person_outline,
        );
      }),
    );
  }
}

class _PasswordInputWidget extends StatelessWidget {
  const _PasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: ((context, state) {
        return TextFieldWithIcon(
          key: const Key('passwordForm_usernameInput_textField'),
          onChanged: (password) => context.read<SignUpBloc>().add(
                SignUpPasswordChanged(
                  password,
                ),
              ),
          obscureText: true,
          labelText: Strings.labelPassword,
          errorText:
              state.password.invalid ? state.password.error!.toText() : null,
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword ||
          previous.password != current.password,
      builder: ((context, state) {
        return TextFieldWithIcon(
          key: const Key('confirmPasswordForm_usernameInput_textField'),
          onChanged: (password) => context.read<SignUpBloc>().add(
                SignUpConfirmPasswordChanged(
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

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? ButtonLoading(
                gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.yellow,
                ],
              ))
            : ButtonWithCenterTitle(
                title: Strings.titleSignUp,
                textColor:
                    state.status.isValidated ? Colors.black : Colors.white,
                onTap: state.status.isValidated
                    ? () {
                        context.read<SignUpBloc>().add(SignUpSubmitted(
                              tokenParam: injector<TokenParam>(),
                            ));
                      }
                    : null,
                gradient: state.status.isValidated
                    ? LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.yellow,
                        ],
                      )
                    : null,
              );
      },
    );
  }
}
