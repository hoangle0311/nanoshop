import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';

enum ConfirmPasswordValidatorError {
  invalid,
  mismatch,
}

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidatorError> {
  final String password;

  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure(password);
  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
      : super.dirty(value);

  @override
  ConfirmPasswordValidatorError? validator(String value) {
    if (value.length < 6) {
      return ConfirmPasswordValidatorError.invalid;
    }

    return password == value ? null : ConfirmPasswordValidatorError.mismatch;
  }
}

extension ConfirmPasswordValidatorErrorX on ConfirmPasswordValidatorError {
  String toText() {
    switch (this) {
      case ConfirmPasswordValidatorError.invalid:
        return Message.invalidPassword;
      case ConfirmPasswordValidatorError.mismatch:
        return Message.mismatchPassword;
    }
  }
}
