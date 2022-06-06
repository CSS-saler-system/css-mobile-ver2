import 'dart:convert';

import 'package:flutter_application_1/src/resource/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalRepository {
  Future<void> saveLogin(LoginResponse loginResponse);
  Future<LoginResponse?> getLoginInfo();
  Future<String> getToken();
  Future<void> deleteLoginInfo();
  Future<String> getUserId();
}

class LocalRepositoryImpl implements LocalRepository {
  final SharedPreferences _sharedPreferences;

  LocalRepositoryImpl(this._sharedPreferences);

  @override
  Future<void> saveLogin(LoginResponse loginResponse) async {
    String userString = jsonEncode(loginResponse);

    await _sharedPreferences.setString("user", userString);
  }

  @override
  Future<LoginResponse?> getLoginInfo() async {
    String? userString = _sharedPreferences.getString("user");
    LoginResponse? loginResponse = userString != null && userString.isNotEmpty
        ? LoginResponse.fromJson(jsonDecode(userString))
        : null;
    return loginResponse;
  }

  @override
  Future<String> getToken() async {
    LoginResponse? loginResponse = await getLoginInfo();
    return "Bearer " + (loginResponse?.jwt_token ?? "");
  }

  @override
  Future<void> deleteLoginInfo() async {
    await _sharedPreferences.remove("user");
  }

  @override
  Future<String> getUserId() async {
    LoginResponse? loginResponse = await getLoginInfo();
    return loginResponse?.id ?? "";
  }
}
