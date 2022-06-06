import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/error_handler.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';
import 'package:flutter_application_1/src/resource/request/create_customer_request.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/resource/services/data_service.dart';

abstract class CustomerRepository {
  Future<Either<Failure, String>> createCustomer(CreateCustomerRequest request);
  Future<Either<Failure, List<CustomerData>>> getCustomers();
}

class CustomerRepositoryImpl implements CustomerRepository {
  final DataService _dataService;
  final LocalRepository _localRepository;

  CustomerRepositoryImpl(this._dataService, this._localRepository);

  @override
  Future<Either<Failure, String>> createCustomer(
      CreateCustomerRequest request) async {
    try {
      final token = await _localRepository.getToken();

      final data = {
        "name": request.name,
        "phone": request.phone,
        "address": request.address,
        "description": request.description,
        "dob": request.dob,
        "accountCreator": {"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6"}
      };

      final response = await _dataService.createCustomer(token, data);
      return Right(response);
    } on DioError catch (e) {
      log("Header" + jsonEncode(e.response!.data));
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<CustomerData>>> getCustomers() async {
    try {
      final token = await _localRepository.getToken();
      List<CustomerData> customers = await _dataService.getCustomers(token);
      return Right(customers);
    } on DioError catch (e) {
      log("Response" + jsonEncode(e.response!.data));
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
