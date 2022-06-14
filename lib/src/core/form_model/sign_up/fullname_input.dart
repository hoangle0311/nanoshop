import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';

enum FullNameInputError {
  invalid,
}

class FullNameInput extends FormzInput<String, FullNameInputError> {
  const FullNameInput.pure([String value = '']) : super.pure(value);
  const FullNameInput.dirty([String value = '']) : super.dirty(value);

  @override
  FullNameInputError? validator(String value) {
    return value.isNotEmpty ? null : FullNameInputError.invalid;
  }
}

extension FullNameInputErrorX on FullNameInputError {
  String toText() {
    switch (this) {
      case FullNameInputError.invalid:
        return Message.invalidFullName;
    }
  }
}
