import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/src/resource/bloc/get_otp_login/get_otp_login_bloc.dart';
import 'package:flutter_application_1/src/resource/services/firebase_auth.dart';
import 'package:flutter_application_1/src/resource/usecase/get_otp_auth_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/verify_otp_login.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  //
  getIt.registerLazySingleton(() => GetOtpAuthUseCase(getIt()));
  getIt.registerLazySingleton(() => VerifyOtpPhoneLogin(getIt()));

  //
  getIt.registerLazySingleton<FirebaseAuthService>(
      () => FirebaseAuthServiceImpl(getIt()));

  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  //
  getIt.registerFactory(() => GetOtpLoginBloc(getIt()));
}
