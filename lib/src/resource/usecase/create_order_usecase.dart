import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/order_repository.dart';
import 'base_usecase.dart';

class CreateOrderUsecase
    extends BaseUseCase<CreateOrderInput, Either<Failure, String>> {
  final OrderRepository _repository;

  CreateOrderUsecase(this._repository);

  @override
  Future<Either<Failure, String>> execute(CreateOrderInput input) async {
    return await _repository.createOrder(input.productId, input.customerId,
        input.quantity, input.address, input.phoneNumber);
  }
}

class CreateOrderInput {
  String productId;
  String customerId;
  String address;
  String phoneNumber;
  int quantity;

  CreateOrderInput({
    required this.productId,
    required this.customerId,
    required this.phoneNumber,
    required this.address,
    required this.quantity,
  });
}
