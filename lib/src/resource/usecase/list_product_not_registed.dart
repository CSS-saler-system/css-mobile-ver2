import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'base_usecase.dart';

class GetProductNotRegistedUseCase extends BaseUseCase<
    GetProductNotRegistedUseCaseInput, Either<Failure, ListProductResponse>> {
  final ProductRepository _repository;

  GetProductNotRegistedUseCase(this._repository);

  @override
  Future<Either<Failure, ListProductResponse>> execute(
      GetProductNotRegistedUseCaseInput input) async {
    return await _repository.getEntepriseNotRegistedProducts(input.entepriseId);
  }
}

class GetProductNotRegistedUseCaseInput {
  final String entepriseId;
  const GetProductNotRegistedUseCaseInput({required this.entepriseId});
}
