import 'package:flutter_application_1/src/resource/repository/auth_reponsitory.dart';
import 'package:flutter_application_1/src/resource/services/firebase_auth.dart';
import 'base_usecase.dart';
import 'package:injectable/injectable.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, bool> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<bool> execute(LoginUseCaseInput input) async {
    return await _repository.login(input.firebaseToken);
  }
}

class LoginUseCaseInput {
  String firebaseToken;

  LoginUseCaseInput(this.firebaseToken);
}
