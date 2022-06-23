import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/response/get_sellings_response.dart';
import 'base_usecase.dart';

class GetSellingsUseCase extends BaseUseCase<GetSellingsUseCaseInput,
    Either<Failure, SellingResponse>> {
  final ProductRepository _repository;

  GetSellingsUseCase(this._repository);

  @override
  Future<Either<Failure, SellingResponse>> execute(
      GetSellingsUseCaseInput input) async {
    return await _repository.getSellings(input.page, input.pageSize);
  }
}

class GetSellingsUseCaseInput {
  final int page;
  final int pageSize;

  GetSellingsUseCaseInput({
    required this.page,
    required this.pageSize,
  });
}
