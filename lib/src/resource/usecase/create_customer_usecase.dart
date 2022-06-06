import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/customer_reponsitory.dart';
import 'package:flutter_application_1/src/resource/request/create_customer_request.dart';
import 'package:flutter_application_1/src/resource/services/firebase_auth.dart';
import 'base_usecase.dart';
import 'package:injectable/injectable.dart';

class CreateCustomerUseCase
    extends BaseUseCase<CreateCustomerInput, Either<Failure, String>> {
  final CustomerRepository _repository;

  CreateCustomerUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(CreateCustomerInput input) async {
    return await _repository.createCustomer(
      CreateCustomerRequest(
        name: input.name,
        phone: input.phone,
        dob: input.dob,
        description: input.description,
        address: input.address,
        accountCreator:
            AccountCreatorRequest(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6"),
      ),
    );
  }
}

class CreateCustomerInput {
  String name;
  String phone;
  String dob;
  String address;
  String description;

  CreateCustomerInput({
    required this.name,
    required this.phone,
    required this.dob,
    required this.address,
    required this.description,
  });
}
