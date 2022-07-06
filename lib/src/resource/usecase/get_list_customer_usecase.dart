import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/customer_reponsitory.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'base_usecase.dart';

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
