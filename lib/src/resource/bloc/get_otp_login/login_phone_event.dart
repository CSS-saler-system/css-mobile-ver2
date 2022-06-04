part of 'login_phone_bloc.dart';

abstract class LoginPhoneEvent extends Equatable {
  const LoginPhoneEvent();

  @override
  List<Object> get props => [];
}

class GetOtpLoginButtonPressed extends LoginPhoneEvent {
  final String phoneNumber;

  const GetOtpLoginButtonPressed({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpLoginButtonPressed extends LoginPhoneEvent {
  final String verificationId;
  final String otp;

  const VerifyOtpLoginButtonPressed(
      {required this.verificationId, required this.otp});

  @override
  List<Object> get props => [verificationId, otp];
}


class LoginServerEvent extends LoginPhoneEvent {
  final String firebaseToken;

  const LoginServerEvent({required this.firebaseToken});

  @override
  List<Object> get props => [firebaseToken];
}