import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';
import 'package:flutter_application_1/src/resource/response/enteprise_response.dart';
import 'package:flutter_application_1/src/resource/services/data_service.dart';

abstract class EntepriseRepository {
  Future<Either<Failure, List<EntepriseData>>> getAllEnteprise();
}

class EntepriseRepositoryImpl extends EntepriseRepository {
  final DataService _dataService;
  final LocalRepository _localRepository;

  EntepriseRepositoryImpl(this._dataService, this._localRepository);

  @override
  Future<Either<Failure, List<EntepriseData>>> getAllEnteprise() async {
    try {
      final userId = await _localRepository.getUserId();
      final response = await _dataService.getEnteprise(1, 100000000);
      return Right(response.data ?? []);
    } on DioError catch (e) {
      String message = e.response?.data?["message"] ?? "";
      return Left(Failure(e.response?.statusCode ?? 500, message));
    }
  }
}
