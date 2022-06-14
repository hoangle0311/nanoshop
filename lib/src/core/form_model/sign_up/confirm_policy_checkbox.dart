import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';

enum ConfirmPolicyError {
  invalid,
}

class ConfirmPolicyCheck extends FormzInput<bool, ConfirmPolicyError> {
  const ConfirmPolicyCheck.pure([
    bool value = false,
  ]) : super.pure(value);
  const ConfirmPolicyCheck.dirty([
    bool value = false,
  ]) : super.dirty(value);

  @override
  ConfirmPolicyError? validator(bool value) {
    return value ? null : ConfirmPolicyError.invalid;
  }
}

extension ConfirmPolicyErrorX on ConfirmPolicyError {
  String toText() {
    switch (this) {
      case ConfirmPolicyError.invalid:
        return Message.invalidPolicy;
    }
  }
}
