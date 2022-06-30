import 'package:flutter_application_1/src/resource/services/firebase_auth.dart';
import 'base_usecase.dart';
import 'package:injectable/injectable.dart';

class GetOtpAuthUseCase extends BaseUseCase<GetOtpAuthUseCaseInput, String> {
  final FirebaseAuthService _service;

  GetOtpAuthUseCase(this._service);

  @override
  Future<String> execute(GetOtpAuthUseCaseInput input) async {
    return await _service.verifyPhoneNumber(input.phoneNumber) ?? "";
  }
}

class GetOtpAuthUseCaseInput {
  String phoneNumber;

  GetOtpAuthUseCaseInput(this.phoneNumber);
}
