import 'package:flutter_application_1/src/resource/services/firebase_auth.dart';
import 'base_usecase.dart';
import 'package:injectable/injectable.dart';

class VerifyOtpPhoneLogin extends BaseUseCase<VerifyOtpPhoneLoginInput, bool> {
  final FirebaseAuthService _service;

  VerifyOtpPhoneLogin(this._service);

  @override
  Future<bool> execute(VerifyOtpPhoneLoginInput input) async {
    return await _service.verifyOtp(input.verificationId, input.otp);
  }
}

class VerifyOtpPhoneLoginInput {
  String verificationId;
  String otp;

  VerifyOtpPhoneLoginInput(this.verificationId, this.otp);
}
