import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/components/dialog_error.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/request/get_order_detail_request.dart';
import 'package:flutter_application_1/src/resource/request/order_request.dart';
import 'package:flutter_application_1/src/resource/services/data_service.dart';

import '../response/order_response.dart';
import 'local_reponsitory.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrder(String productId,
      String customerId, int quantity, String address, String phoneNumber);

  Future<Either<Failure, GetOrders>> getOrders(GetOrdersRequest request);

  Future<Either<Failure, OrderObject>> getOrderDetail(
      GetOrderDetailRequest request);
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
      String message = e.response?.data?["message"] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }

  @override
  Future<Either<Failure, GetOrders>> getOrders(GetOrdersRequest request) async {
    try {
      final String token = await _localRepository.getToken();
      final String collaboratorId = await _localRepository.getUserId();
      GetOrders result = await _dataService.getOrders(token, collaboratorId);
      return Right(result);
    } on DioError catch (e) {
      String message = e.response?.data?["message"] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }

  @override
  Future<Either<Failure, OrderObject>> getOrderDetail(
      GetOrderDetailRequest request) async {
    try {
      final String token = await _localRepository.getToken();
      OrderObject orderObj =
          await _dataService.getOrderDetail(token, request.orderId);
      return Right(orderObj);
    } on DioError catch (e) {
      // dynamic response = jsonDecode(e.response?.data);

      String message = e.response?.data?["message"] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }
}
