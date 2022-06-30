import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/components/dialog_error.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/services/data_service.dart';

import 'local_reponsitory.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrder(String productId,
      String customerId, int quantity, String address, String phoneNumber);
}

class OrderRepositoryImpl implements OrderRepository {
  final DataService _dataService;
  final LocalRepository _localRepository;

  const OrderRepositoryImpl(this._dataService, this._localRepository);

  @override
  Future<Either<Failure, String>> createOrder(
      String productId,
      String customerId,
      int quantity,
      String address,
      String phoneNumber) async {
    try {
      final String token = await _localRepository.getToken();
      final String accounId = await _localRepository.getUserId();

      final body = {
        "account": {"accountId": accounId},
        "customer": {"customerId": customerId},
        "deliveryAddress": address,
        "deliveryPhone": phoneNumber,
        "orderDetails": [
          {
            "quantity": quantity,
            "product": {"productId": productId}
          }
        ]
      };

      String orderId = await _dataService.newOrder(token, body);

      return Right(orderId);
    } on DioError catch (e) {
      log(e.message);
      String message = jsonDecode(e.response?.data)?['message'] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }
}
