import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nanoshop/src/config/routers/app_router/app_router.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/core/assets/image_path.dart';
import 'package:nanoshop/src/core/form_model/login/password_input.dart';
import 'package:nanoshop/src/core/form_model/login/username_input.dart';
import 'package:nanoshop/src/core/toast/toast.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nanoshop/src/presentation/views/components/remove_focus_widget/remove_focus_widget.dart';

import '../../../config/styles/app_text_style.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../blocs/login_bloc/login_bloc.dart';
import '../../views/components/buttons/button_icon_with_title.dart';
import '../../views/components/buttons/button_loading.dart';
import '../../views/components/buttons/button_with_center_title.dart';
import '../../views/components/text_field/text_field_with_icon.dart';

class ScLogin extends StatelessWidget {
  const ScLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RemoveFocusWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (context) => injector<LoginBloc>(),
          child: Stack(
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
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          context.read<AuthenticationBloc>().add(
                AuthenticationUserRequest(
                  userId: state.userLogin.userId!,
                  tokenParam: injector<TokenParam>(),
                ),
              );
          Navigator.of(context).pop(true);
        }
        if (state.status == FormzStatus.submissionFailure) {
          Toast.showText(
            "Đăng nhập thất bại",
            iconData: Icons.sms_failed,
          );
        }
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Quay lại',
                  style: TextStyleApp.textStyle1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _UsernameInputWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    _PasswordInputWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Quên mật khẩu?",
                      textAlign: TextAlign.end,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: AppColors.yellow,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _LoginButton(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Hoặc đăng nhập với",
                      textAlign: TextAlign.center,
                      style: TextStyleApp.textStyle2.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonIconWithTitle(
                            assetsSource: ImagePath.googleIcon,
                            title: 'Google',
                            borderColor: AppColors.primaryColor,
                            textColor: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonIconWithTitle(
                            assetsSource: ImagePath.facebookIcon,
                            title: 'Facebook',
                            borderColor: AppColors.primaryColor,
                            textColor: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Bạn chưa có tài khoản ? ",
                              style: TextStyleApp.textStyle2.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: "Đăng ký ngay.",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouterEndPoint.SIGNUP);
                                },
                              style: TextStyleApp.textStyle2.copyWith(
                                color: AppColors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordInputWidget extends StatelessWidget {
  const _PasswordInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: ((context, state) {
        return TextFieldWithIcon(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.read<LoginBloc>().add(
                LoginPasswordChanged(
                  password,
                ),
              ),
          labelText: Strings.labelPassword,
          errorText:
              state.password.invalid ? state.password.error!.toText() : null,
          iconData: Icons.lock,
          obscureText: true,
        );

        // return TextField(
        //   key: const Key('loginForm_passwordInput_textField'),
        //   obscureText: true,
        //   onChanged: (password) => context.read<LoginBloc>().add(
        //         LoginPasswordChanged(
        //           password,
        //         ),
        //       ),
        //   decoration: InputDecoration(
        //     labelText: Strings.labelPassword,
        //     errorText: state.password.invalid ? Message.invalidPassword : null,
        //   ),
        // );
      }),
    );
  }
}

class _UsernameInputWidget extends StatelessWidget {
  const _UsernameInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: ((context, state) {
        return TextFieldWithIcon(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) => context.read<LoginBloc>().add(
                LoginUsernameChanged(
                  username,
                ),
              ),
          labelText: Strings.labelAccount,
          errorText:
              state.username.invalid ? state.username.error!.toText() : null,
          iconData: Icons.person_outline,
        );

        // return TextField(
        //   key: const Key('loginForm_usernameInput_textField'),
        //   onChanged: (username) => context.read<LoginBloc>().add(
        //         LoginUsernameChanged(
        //           username,
        //         ),
        //       ),
        //   decoration: InputDecoration(
        //     labelText: Strings.labelAccount,
        //     errorText: state.username.invalid ? Message.invalidPhone : null,
        //   ),
        // );
      }),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
                title: 'Đăng nhập',
                textColor:
                    state.status.isValidated ? Colors.white : Colors.grey,
                onTap: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(
                              LoginSubmitted(
                                tokenParam: injector<TokenParam>(),
                              ),
                            );
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
        // ElevatedButton(
        //     key: const Key('loginForm_continue_raisedButton'),
        //     child: const Text('Login'),
        //     onPressed: state.status.isValidated
        //         ? () {
        //             context.read<LoginBloc>().add(const LoginSubmitted());
        //           }
        //         : null,
        //   );
      },
    );
  }
}
