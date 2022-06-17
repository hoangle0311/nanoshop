import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';

enum ContentValidatorError {
  invalid,
}

class ContentInput extends FormzInput<String, ContentValidatorError> {
  const ContentInput.pure([String value = '']) : super.pure(value);
  const ContentInput.dirty([String value = '']) : super.dirty(value);

  @override
  ContentValidatorError? validator(String value) {
    return value.length >= 20 ? null : ContentValidatorError.invalid;
  }
}

extension ContentValidatorErrorX on ContentValidatorError {
  String toText() {
    switch (this) {
      case ContentValidatorError.invalid:
        return Message.invalidContent;
    }
  }
}
