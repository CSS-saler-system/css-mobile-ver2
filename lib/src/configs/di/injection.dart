import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/src/resource/bloc/campaign_bloc/campaign_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/create_customer_bloc/create_customer_bloc_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/customer_bloc/customer_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/get_otp_login/login_phone_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/order_bloc/order_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/selling_bloc/selling_bloc_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/update_customer_bloc/update_customer_bloc_bloc.dart';
import 'package:flutter_application_1/src/resource/repository/auth_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/customer_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/order_repository.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/services/data_service.dart';
import 'package:flutter_application_1/src/resource/services/firebase_auth.dart';
import 'package:flutter_application_1/src/resource/usecase/create_customer_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/create_order_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/create_selling_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_campaigns_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_customer_detail_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_list_customer_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_otp_auth_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_product_detail_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_products_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_sellings_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/login_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/update_customer_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/verify_otp_login.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  Dio dio = Dio();
  dio.options.contentType = "application/json";
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  ));
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => DataService(dio));
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
  getIt.registerLazySingleton(() => UpdateCustomerUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateSellingUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSellingsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCampaignsUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateOrderUsecase(getIt()));

  // FIREBASE_SERVICE
  getIt.registerLazySingleton<FirebaseAuthService>(
      () => FirebaseAuthServiceImpl(getIt()));

  // BLOC
  getIt.registerFactory(() => LoginPhoneBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => CreateCustomerBlocBloc(getIt()));
  getIt.registerFactory(() => GetProductsBloc(getIt(), getIt()));
  getIt.registerFactory(() => CustomerBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => UpdateCustomerBlocBloc(getIt()));
  getIt.registerFactory(() => SellingBlocBloc(getIt(), getIt()));
  getIt.registerFactory(() => CampaignBloc(getIt()));
  getIt.registerFactory(() => OrderBloc(getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CustomerRepository>(
      () => CustomerRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(getIt(), getIt()));
}

Future<void> _initSharedPref() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);
}
