import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';

enum PasswordValidatorError {
  invalid,
}

class PasswordInput extends FormzInput<String, PasswordValidatorError> {
  const PasswordInput.pure([String value = '']) : super.pure(value);
  const PasswordInput.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidatorError? validator(String value) {
    return value.length > 6 ? null : PasswordValidatorError.invalid;
  }
}

extension PasswordValidatorErrorX on PasswordValidatorError {
  String toText() {
    switch (this) {
      case PasswordValidatorError.invalid:
        return Message.invalidPassword;
    }
  }
}
