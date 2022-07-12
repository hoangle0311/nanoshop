import 'dart:convert';

import 'package:nanoshop/src/core/constant/db_key/shared_paths.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentLocalService {
  final SharedPreferences _sharedPreferences;

  PaymentLocalService(
    this._sharedPreferences,
  );

  Address? getAddressLocal() {
    final Address address;

    try {
      final jsonString =
          _sharedPreferences.getString(SharedPaths.address) ?? '';

      address = Address.fromJson(json.decode(jsonString));

      return address;
    } catch (e) {
      return null;
    }
  }

  Future<void> setAddressLocal(Address address) async {
    await _sharedPreferences.setString(
      SharedPaths.address,
      json.encode(
        address.toJson(),
      ),
    );
  }
}
