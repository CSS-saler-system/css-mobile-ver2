import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/usecase/get_otp_auth_usecase.dart';

part 'get_otp_login_event.dart';
part 'get_otp_login_state.dart';

class GetOtpLoginBloc extends Bloc<GetOtpLoginEvent, GetOtpLoginState> {
  final GetOtpAuthUseCase _getOtpAuthUseCase;

  GetOtpLoginBloc(this._getOtpAuthUseCase) : super(GetOtpLoginInitial()) {
    on<GetOtpLoginButtonPressed>(_getOtpLoginEvent);
  }

  FutureOr<void> _getOtpLoginEvent(
      GetOtpLoginButtonPressed event, Emitter<GetOtpLoginState> emit) async {
    emit(GetOtpLoginLoading());
    String result = await _getOtpAuthUseCase
        .execute(GetOtpAuthUseCaseInput(event.phoneNumber));
    if (result.isNotEmpty) {
      emit(GetOtpLoginSuccess(verificationId: result));
    } else {
      emit(GetOtpLoginFailure(error: "Something went wrong"));
    }
  }
}
