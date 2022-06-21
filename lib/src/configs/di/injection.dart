import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/src/resource/bloc/create_customer_bloc/create_customer_bloc_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/customer_bloc/customer_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/get_otp_login/login_phone_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/repository/auth_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/customer_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/services/data_service.dart';
import 'package:flutter_application_1/src/resource/services/firebase_auth.dart';
import 'package:flutter_application_1/src/resource/usecase/create_customer_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_customer_detail_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_list_customer_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_otp_auth_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_product_detail_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_products_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/login_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/verify_otp_login.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(
      () => DataService(Dio(BaseOptions(contentType: "application/json"))));
  // getIt.registerSingletonAsync<SharedPreferences>(
  //     () => SharedPreferences.getInstance());

  await _initSharedPref();

  // USE_CASE
  getIt.registerLazySingleton(() => GetOtpAuthUseCase(getIt()));
  getIt.registerLazySingleton(() => VerifyOtpPhoneLogin(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateCustomerUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProductsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCustomersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProductDetailUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCustomerDetailUseCase(getIt()));

  // FIREBASE_SERVICE
  getIt.registerLazySingleton<FirebaseAuthService>(
      () => FirebaseAuthServiceImpl(getIt()));

  // BLOC
  getIt.registerFactory(() => LoginPhoneBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => CreateCustomerBlocBloc(getIt()));
  getIt.registerFactory(() => GetProductsBloc(getIt(), getIt()));
  getIt.registerFactory(() => CustomerBloc(getIt(), getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CustomerRepository>(
      () => CustomerRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt(), getIt()));
}

Future<void> _initSharedPref() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);
}
