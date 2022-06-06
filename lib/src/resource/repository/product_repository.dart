import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/error_handler.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';
import 'package:flutter_application_1/src/resource/request/get_list_product_request.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';

import '../services/data_service.dart';

abstract class ProductRepository {
  Future<Either<Failure, ListProductResponse>> getListProduct(
      GetListProductRequest request);

  Future<Either<Failure, ProductData>> getProductDetail(String productId);
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
        token,
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
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ProductData>> getProductDetail(
      String productId) async {
    try {
      final String token = await _localRepository.getToken();
      ProductData result = await _dataService.getProductDetail(
        token,
        productId,
      );

      return Right(result);
    } on DioError catch (e) {
      log(e.toString());
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
