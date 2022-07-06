import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/order_repository.dart';
import 'package:flutter_application_1/src/resource/request/get_order_detail_request.dart';
import '../response/order_response.dart';
import 'base_usecase.dart';

class GetOrderDetailUseCase extends BaseUseCase<GetOrderDetailUseCaseInput,
    Either<Failure, OrderObject>> {
  final OrderRepository _repository;

  GetOrderDetailUseCase(this._repository);

  @override
  Future<Either<Failure, OrderObject>> execute(
      GetOrderDetailUseCaseInput input) async {
    return await _repository
        .getOrderDetail(GetOrderDetailRequest(orderId: input.orderId));
  }
}

class GetOrderDetailUseCaseInput {
  final String orderId;
  const GetOrderDetailUseCaseInput({required this.orderId});
}
