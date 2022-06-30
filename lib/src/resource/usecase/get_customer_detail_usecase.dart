import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/customer_reponsitory.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'base_usecase.dart';

class GetCustomerDetailUseCase
    extends BaseUseCase<GetCustomerDetailInput, Either<Failure, CustomerData>> {
  final CustomerRepository _repository;

  GetCustomerDetailUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerData>> execute(
      GetCustomerDetailInput input) async {
    return await _repository.getCustomer(input.customerId);
  }
}

class GetCustomerDetailInput {
  final String customerId;

  const GetCustomerDetailInput({
    required this.customerId,
  });
}
