import 'package:formz/formz.dart';
import 'package:nanoshop/src/domain/entities/filter_model/filter_model.dart';

import '../../constant/message/message.dart';

enum LocationError {
  invalid,
}

class LocationFormModel extends FormzInput<FilterModel?, LocationError> {
  const LocationFormModel.pure([
    FilterModel? value,
  ]) : super.pure(value);

  const LocationFormModel.dirty([
    FilterModel? value,
  ]) : super.dirty(value);

  @override
  LocationError? validator(FilterModel? value) {
    return value != null ? null : LocationError.invalid;
  }
}

extension LocationErrorX on LocationError {
  String toText() {
    switch (this) {
      case LocationError.invalid:
        return Message.notEmpty;
    }
  }
}
