import 'package:flutter_application_1/src/resource/repository/auth_reponsitory.dart';
import 'base_usecase.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, bool> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<bool> execute(LoginUseCaseInput input) async {
    return await _repository.login(input.firebaseToken, input.registrationToken);
  }
}

class LoginUseCaseInput {
 final String firebaseToken;
 final String registrationToken;

 const LoginUseCaseInput({required this.firebaseToken, required this.registrationToken});
}
