import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/usecase/get_otp_auth_usecase.dart';

import '../../usecase/verify_otp_login.dart';

part 'login_phone_event.dart';
part 'login_phone_state.dart';

class LoginPhoneBloc extends Bloc<LoginPhoneEvent, LoginPhoneState> {
  final GetOtpAuthUseCase _getOtpAuthUseCase;
  final VerifyOtpPhoneLogin _verifyOtpPhoneLogin;

  LoginPhoneBloc(this._getOtpAuthUseCase, this._verifyOtpPhoneLogin)
      : super(GetOtpLoginInitial()) {
    on<GetOtpLoginButtonPressed>(_getOtpLoginEvent);
    on<VerifyOtpLoginButtonPressed>(_verifyOtpLoginEvent);
  }

  FutureOr<void> _getOtpLoginEvent(
      GetOtpLoginButtonPressed event, Emitter<LoginPhoneState> emit) async {
    emit(GetOtpLoginLoading());
    String result = await _getOtpAuthUseCase
        .execute(GetOtpAuthUseCaseInput(event.phoneNumber));
    log(result);
    if (result.isNotEmpty) {
      emit(GetOtpLoginSuccess(verificationId: result));
    } else {
      emit(const GetOtpLoginFailure(error: "Something went wrong"));
    }
  }

  Future<void> _verifyOtpLoginEvent(
      VerifyOtpLoginButtonPressed event, Emitter<LoginPhoneState> emit) async {
    emit(VerifyOtpLoading());
    bool result = await _verifyOtpPhoneLogin
        .execute(VerifyOtpPhoneLoginInput(event.verificationId, event.otp));
    if (result) {
      emit(VerifyOtpSuccess());
    } else {
      emit(const VerifyOtpFailure(error: "Something went wrong"));
    }
  }
}
