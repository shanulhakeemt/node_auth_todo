import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    print("shared preeeeeeeeeeeee");
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setToken(String? token) async {
    if (token != null) {
      _sharedPreferences.setString('x-auth-token', token);
    }
  }

  void clearSharedPreference() {
    _sharedPreferences.clear();
  }

  String? getToken() {
    return _sharedPreferences.getString('x-auth-token');
  }
}
