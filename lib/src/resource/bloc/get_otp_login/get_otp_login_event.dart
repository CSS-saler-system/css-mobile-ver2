part of 'get_otp_login_bloc.dart';

abstract class GetOtpLoginEvent extends Equatable {
  const GetOtpLoginEvent();

  @override
  List<Object> get props => [];
}

class GetOtpLoginButtonPressed extends GetOtpLoginEvent {
  final String phoneNumber;

  const GetOtpLoginButtonPressed({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}
