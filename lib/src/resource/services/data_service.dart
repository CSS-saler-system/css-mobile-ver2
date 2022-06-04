import 'package:flutter_application_1/src/resource/response/login_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'data_service.g.dart';

@RestApi(
    baseUrl: "https://happy-bee-api.azurewebsites.net/api/v3.0/collaborator/")
abstract class DataService {
  factory DataService(Dio dio) = _DataService;

  @POST("login")
  Future<LoginResponse> login(@Query("firebaseToken") String firebaseToken);
}
