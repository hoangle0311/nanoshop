import 'package:nanoshop/src/domain/entities/user_login/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constant/db_key/shared_paths.dart';

class UserLocalService {
  final SharedPreferences _sharedPreferences;

  UserLocalService(
    this._sharedPreferences,
  );

  String? getUserIdLocal() {
    try {
      final userId = _sharedPreferences.getString(SharedPaths.userId);

      return userId;
    } catch (e) {
      return null;
    }
  }

  Future<void> addUserLocal(UserLogin userLogin) async {
    await _sharedPreferences.setString(
      SharedPaths.userId,
      userLogin.userId!,
    );
  }

  Future<void> removeUserLocal() async {
    await _sharedPreferences.remove(
      SharedPaths.userId,
    );
  }
}
