import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';

import 'package:flutter_application_1/src/resource/response/login_response.dart';
import 'package:flutter_application_1/src/resource/services/data_service.dart';

abstract class AuthRepository {
  Future<bool> login(String firebaseToken, String registrationToken);
}

class AuthRepositoryImpl implements AuthRepository {
  final DataService _dataService;
  final LocalRepository _localRepository;
  final String a;

  AuthRepositoryImpl(this._dataService, this._localRepository, this.a);

  @override
  Future<bool> login(String firebaseToken, String registrationToken) async {
    try {
      log('login: firebaseToken: $firebaseToken, registrationToken: $registrationToken');
      LoginResponse response =
          await _dataService.login(firebaseToken, registrationToken);
      _localRepository.saveLogin(response);
      return true;
    } on DioError catch (e) {
      log("Login error: ${e.response?.requestOptions.path}");
      return false;
    }
  }
}
