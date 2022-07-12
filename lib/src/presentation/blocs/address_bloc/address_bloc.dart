import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:nanoshop/src/core/form_model/location/location_form_model.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';
import 'package:nanoshop/src/domain/entities/filter_model/filter_model.dart';
import 'package:nanoshop/src/domain/usecases/payment_usecase/get_address_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/payment_usecase/set_address_local_usecase.dart';

import '../../../core/form_model/login/username_input.dart';
import '../../../core/form_model/sign_up/fullname_input.dart';
import '../../../core/utils/log/log.dart';

part 'address_event.dart';

part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddressLocalUsecase _getAddressLocalUsecase;
  final SetAddressLocalUsecase _setAddressLocalUsecase;

  AddressBloc(
    this._getAddressLocalUsecase,
    this._setAddressLocalUsecase,
  ) : super(const AddressState()) {
    on<LocationNameChanged>(_onNameChanged);
    on<LocationPhoneChanged>(_onPhoneChanged);
    on<LocationAddressChanged>(_onAddressChanged);
    on<LocationSexChanged>(_onSexChanged);
    on<LocationCityChanged>(_onCityChanged);
    on<LocationDistrictChanged>(_onDistrictChanged);
    on<LocationWardChanged>(_onWardChanged);
    on<AddressPaymentAdd>(_onAddressPayment);
    on<CheckLocalAddress>(_getAddressLocalPayment);
    on<SetLocalAddress>(_setAddressLocalPayment);
  }

  _setAddressLocalPayment(SetLocalAddress event, emit) async {
    await _setAddressLocalUsecase.call(event.address);
  }

  _getAddressLocalPayment(CheckLocalAddress event, emit) {
    Address? address = _getAddressLocalUsecase.call(null);

    // Log.i(address.toString());

    if (address != null) {
      final name = FullNameInput.dirty(
        address.name,
      );
      final phone = UsernameInput.dirty(
        address.phone,
      );
      final _$address = FullNameInput.dirty(
        address.address,
      );
      final sex = LocationFormModel.dirty(
        FilterModel(
          id: address.sex,
        ),
      );
      final city = LocationFormModel.dirty(
        FilterModel(
          id: address.city,
        ),
      );
      final district = LocationFormModel.dirty(
        FilterModel(
          id: address.district,
        ),
      );
      final ward = LocationFormModel.dirty(
        FilterModel(
          id: address.ward,
        ),
      );
      emit(
        state.copyWith(
          name: name,
          phone: phone,
          address: _$address,
          sex: sex,
          city: city,
          district: district,
          ward: ward,
          addressPayment: address,
          status: Formz.validate(
            [
              phone,
              _$address,
              name,
              sex,
              city,
              district,
              ward,
            ],
          ),
        ),
      );
    }
  }

  _onAddressPayment(AddressPaymentAdd event, emit) {
    emit(
      state.copyWith(
        addressPayment: event.address,
      ),
    );
  }

// LocationNameChanged
  _onNameChanged(LocationNameChanged event, emit) {
    final name = FullNameInput.dirty(
      event.name,
    );

    emit(
      state.copyWith(
        name: name,
        status: Formz.validate(
          [
            state.phone,
            state.address,
            state.sex,
            state.city,
            state.ward,
            state.district,
            name,
          ],
        ),
      ),
    );
  }

// LocationPhoneChanged
  _onPhoneChanged(LocationPhoneChanged event, emit) {
    final phone = UsernameInput.dirty(
      event.phone,
    );

    emit(
      state.copyWith(
        phone: phone,
        status: Formz.validate(
          [
            phone,
            state.address,
            state.sex,
            state.city,
            state.ward,
            state.district,
            state.name,
          ],
        ),
      ),
    );
  }

// LocationAddressChanged
  _onAddressChanged(LocationAddressChanged event, emit) {
    final address = FullNameInput.dirty(
      event.address,
    );

    emit(
      state.copyWith(
        address: address,
        status: Formz.validate(
          [
            state.phone,
            address,
            state.sex,
            state.city,
            state.ward,
            state.district,
            state.name,
          ],
        ),
      ),
    );
  }

// LocationSexChanged
  _onSexChanged(LocationSexChanged event, emit) {
    final sex = LocationFormModel.dirty(
      event.sex,
    );

    emit(
      state.copyWith(
        sex: sex,
        status: Formz.validate(
          [
            state.phone,
            state.address,
            sex,
            state.city,
            state.ward,
            state.district,
            state.name,
          ],
        ),
      ),
    );
  }

// LocationCityChanged
  _onCityChanged(LocationCityChanged event, emit) {
    final city = LocationFormModel.dirty(
      event.city,
    );
    emit(
      state.copyWith(
        city: city,
        status: Formz.validate(
          [
            state.phone,
            state.address,
            state.sex,
            city,
            state.ward,
            state.district,
            state.name,
          ],
        ),
      ),
    );
  }

// LocationDistrictChanged
  _onDistrictChanged(LocationDistrictChanged event, emit) {
    final district = LocationFormModel.dirty(
      event.district,
    );

    emit(
      state.copyWith(
        district: district,
        status: Formz.validate(
          [
            state.phone,
            state.address,
            state.sex,
            state.city,
            state.ward,
            district,
            state.name,
          ],
        ),
      ),
    );
  }

// LocationWardChanged
  _onWardChanged(LocationWardChanged event, emit) {
    final ward = LocationFormModel.dirty(
      event.ward,
    );

    emit(
      state.copyWith(
        ward: ward,
        status: Formz.validate(
          [
            state.phone,
            state.address,
            state.sex,
            state.city,
            ward,
            state.district,
            state.name,
          ],
        ),
      ),
    );
  }
}
