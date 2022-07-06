import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/order_repository.dart';
import 'package:flutter_application_1/src/resource/request/order_request.dart';
import '../response/order_response.dart';
import 'base_usecase.dart';

class GetOrdersUseCase
    extends BaseUseCase<GetOrderUseCaseInput, Either<Failure, GetOrders>> {
  final OrderRepository _repository;

  GetOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, GetOrders>> execute(GetOrderUseCaseInput input) async {
    return await _repository.getOrders(GetOrdersRequest());
  }
}

class GetOrderUseCaseInput {
  const GetOrderUseCaseInput();
}
