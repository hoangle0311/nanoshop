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

  int getCountMessageLocal() {
    final messageCount = _sharedPreferences.getInt(SharedPaths.message) ?? 0;

    return messageCount;
  }

  Future<void> addUserLocal(UserLogin userLogin) async {
    await _sharedPreferences.setString(
      SharedPaths.userId,
      userLogin.userId!,
    );
  }

  Future<void> addCountMessageLocal() async {
    try {
      final messageCount = _sharedPreferences.getInt(SharedPaths.message) ?? 0;

      await _sharedPreferences.setInt(
        SharedPaths.message,
        messageCount + 1,
      );
    } catch (e) {
      return;
    }
  }

  Future<void> removeCountMessageLocal() async {
    await _sharedPreferences.remove(
      SharedPaths.message,
    );
  }

  Future<void> removeUserLocal() async {
    await _sharedPreferences.remove(
      SharedPaths.userId,
    );
    await _sharedPreferences.remove(
      SharedPaths.message,
    );
  }
}
