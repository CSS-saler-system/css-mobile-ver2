part of 'get_otp_login_bloc.dart';

abstract class GetOtpLoginState extends Equatable {
  const GetOtpLoginState();

  @override
  List<Object> get props => [];
}

class GetOtpLoginInitial extends GetOtpLoginState {}

class GetOtpLoginLoading extends GetOtpLoginState {}

class GetOtpLoginSuccess extends GetOtpLoginState {
  final String verificationId;

  const GetOtpLoginSuccess({required this.verificationId});

  @override
  List<Object> get props => [verificationId];
}

class GetOtpLoginFailure extends GetOtpLoginState {
  final String error;

  const GetOtpLoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
