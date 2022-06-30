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
  final String registrationToken;

  const VerifyOtpLoginButtonPressed({
    required this.verificationId,
    required this.otp,
    required this.registrationToken,
  });

  @override
  List<Object> get props => [verificationId, otp];
}

class LoginServerEvent extends LoginPhoneEvent {
  final String firebaseToken;
  final String registrationToken;

  const LoginServerEvent({
    required this.firebaseToken,
    required this.registrationToken,
  });

  @override
  List<Object> get props => [firebaseToken];
}
