import 'package:flutter/material.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../config/styles/app_color.dart';
import '../../../config/styles/app_text_style.dart';
import '../../../core/constant/strings/strings.dart';
import '../../views/components/text_field/text_field_input.dart';

class ScUpdateInformation extends StatelessWidget {
  const ScUpdateInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
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
                child: _UpdateNameInputWidget(),
              ),
              SizedBox(
                height: 20,
              ),
              _TitleInput(
                title: "Địa chỉ",
                child: _UpdateNameInputWidget(),
              ),
            ],
          ),
        ),
      ),
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
    return TextFieldInput(
      key: const Key('passwordForm_usernameInput_textField'),
      // onChanged: (password) => context.read<ChangePasswordBloc>().add(
      //   NewPasswordChanged(
      //     password,
      //   ),
      // ),
      labelText: Strings.labelPassword,
      // errorText: state.newPassword.invalid
      //     ? state.newPassword.error!.toText()
      //     : null,
      iconData: Icons.person,
    );
  }
}