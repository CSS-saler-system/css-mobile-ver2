import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/error_handler.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';
import 'package:flutter_application_1/src/resource/request/get_list_product_request.dart';
import 'package:flutter_application_1/src/resource/response/campaign_response.dart';
import 'package:flutter_application_1/src/resource/response/get_sellings_response.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';

import '../services/data_service.dart';

abstract class ProductRepository {
  Future<Either<Failure, ListProductResponse>> getListProduct(
      GetListProductRequest request);

  Future<Either<Failure, ProductData>> getProductDetail(String productId);

  Future<Either<Failure, String>> createSelling(String productId);
  Future<Either<Failure, SellingResponse>> getSellings(int page, int pageSize);

  Future<Either<Failure, CapmpaignsResponse>> getcampagins();
}

class ProductRepositoryImpl implements ProductRepository {
  final DataService _dataService;
  final LocalRepository _localRepository;

  const ProductRepositoryImpl(this._dataService, this._localRepository);

  @override
  Future<Either<Failure, ListProductResponse>> getListProduct(
      GetListProductRequest request) async {
    try {
      final String token = await _localRepository.getToken();
      ListProductResponse result = await _dataService.getProducts(
        // token,
        request.page,
        request.pageSize,
        request.status,
        request.pointSale,
        request.price,
        request.inStock,
        request.brand,
        request.productName,
      );
      return Right(result);
    } on DioError catch (e) {
      log(e.message);
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductData>> getProductDetail(
      String productId) async {
    try {
      final String token = await _localRepository.getToken();
      final accounId = await _localRepository.getUserId();
      log("account Id" + accounId);
      log('TOKEN:' + token);
      ProductData result = await _dataService.getProductDetail(
        token,
        productId,
      );

      return Right(result);
    } on DioError catch (e) {
      String message = e.response?.data?["message"] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }

  @override
  Future<Either<Failure, String>> createSelling(String productId) async {
    try {
      final String token = await _localRepository.getToken();
      final accounId = await _localRepository.getUserId();

      log("ACID: " + accounId);
      final body = {
        "product": {"productId": productId},
        "collaborator": {"accountId": accounId}
      };

      String result = await _dataService.sellingCreate(token, body);

      return Right(result);
    } on DioError catch (e) {
      String message = e.response?.data?["message"] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }

  @override
  Future<Either<Failure, SellingResponse>> getSellings(
      int page, int pageSize) async {
    try {
      final String token = await _localRepository.getToken();
      final accounId = await _localRepository.getUserId();
      SellingResponse sellingResponse =
          await _dataService.getSellings(token, accounId, page, pageSize);
      return Right(sellingResponse);
    } on DioError catch (e) {
      String message = e.response?.data?["message"] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }

  @override
  Future<Either<Failure, CapmpaignsResponse>> getcampagins() async {
    try {
      final String token = await _localRepository.getToken();
      CapmpaignsResponse sellingResponse =
          await _dataService.getCampaigns(token);
      return Right(sellingResponse);
    } on DioError catch (e) {
      String message = e.response?.data?["message"] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }
}
