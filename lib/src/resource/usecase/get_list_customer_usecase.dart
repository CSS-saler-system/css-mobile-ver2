import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/customer_reponsitory.dart';
import 'package:flutter_application_1/src/resource/request/create_customer_request.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/resource/services/firebase_auth.dart';
import 'base_usecase.dart';
import 'package:injectable/injectable.dart';

class GetCustomersUseCase extends BaseUseCase<GetCustomersUseCaseInput,
    Either<Failure, List<CustomerData>>> {
  final CustomerRepository _repository;

  GetCustomersUseCase(this._repository);

  @override
  Future<Either<Failure, List<CustomerData>>> execute(
      GetCustomersUseCaseInput input) async {
    return await _repository.getCustomers();
  }
}

class GetCustomersUseCaseInput {
  const GetCustomersUseCaseInput();
}
