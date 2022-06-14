import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';

enum UsernameValidatorError {
  invalid,
}

class UsernameInput extends FormzInput<String, UsernameValidatorError> {
  const UsernameInput.pure([String value = '']) : super.pure(value);
  const UsernameInput.dirty([String value = '']) : super.dirty(value);

  static final _userRegExp = RegExp(
    r'^(?:[+0]9)?[0-9]{10}$',
  );

  @override
  UsernameValidatorError? validator(String value) {
    return _userRegExp.hasMatch(value) ? null : UsernameValidatorError.invalid;
  }
}

extension UsernameValidatorErrorX on UsernameValidatorError {
  String toText() {
    switch (this) {
      case UsernameValidatorError.invalid:
        return Message.invalidPhone;
    }
  }
}
