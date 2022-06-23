import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/customer_reponsitory.dart';
import 'package:flutter_application_1/src/resource/request/update_customer_request.dart';
import 'base_usecase.dart';

class UpdateCustomerUseCase
    extends BaseUseCase<UpdateCustomerInput, Either<Failure, bool>> {
  final CustomerRepository _repository;

  UpdateCustomerUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(UpdateCustomerInput input) async {
    return await _repository.updateCustomer(
      UpdateCustomerRequest(
        name: input.name,
        phone: input.phone,
        dob: input.dob,
        description: input.description,
        id: input.id,
        address: input.address,
        accountCreator:
            AccountCreatorRequest(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6"),
      ),
    );
  }
}

class UpdateCustomerInput {
  String name;
  String phone;
  String dob;
  String address;
  String description;
  String id;

  UpdateCustomerInput({
    required this.name,
    required this.phone,
    required this.dob,
    required this.address,
    required this.description,
    required this.id
  });
}
