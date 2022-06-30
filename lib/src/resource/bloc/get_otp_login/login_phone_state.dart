part of 'login_phone_bloc.dart';

abstract class LoginPhoneState extends Equatable {
  const LoginPhoneState();

  @override
  List<Object> get props => [];
}

class GetOtpLoginInitial extends LoginPhoneState {}

class GetOtpLoginLoading extends LoginPhoneState {}

class GetOtpLoginSuccess extends LoginPhoneState {
  final String verificationId;

  const GetOtpLoginSuccess({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}

class GetOtpLoginFailure extends LoginPhoneState {
  final String error;

  const GetOtpLoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class VerifyOtpLoading extends LoginPhoneState {}

class VerifyOtpSuccess extends LoginPhoneState {
  final String firebaseToken;

  const VerifyOtpSuccess({required this.firebaseToken});

  @override
  List<Object> get props => [firebaseToken];
}

class VerifyOtpFailure extends LoginPhoneState {
  final String error;
  const VerifyOtpFailure({required this.error});
  @override
  List<Object> get props => [error];
}

class LoginServerLoading extends LoginPhoneState {}

class LoginServerSuccess extends LoginPhoneState {}

class LoginServerFailure extends LoginPhoneState {}
