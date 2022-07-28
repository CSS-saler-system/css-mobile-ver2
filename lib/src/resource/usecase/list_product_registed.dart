import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'base_usecase.dart';

class GetProductRegistedUseCase extends BaseUseCase<
    GetProductRegistedUseCaseInput, Either<Failure, ListProductResponse>> {
  final ProductRepository _repository;

  GetProductRegistedUseCase(this._repository);

  @override
  Future<Either<Failure, ListProductResponse>> execute(
      GetProductRegistedUseCaseInput input) async {
    return await _repository.getEntepriseRegistedProducts(input.entepriseId);
  }
}

class GetProductRegistedUseCaseInput {
  final String entepriseId;
  const GetProductRegistedUseCaseInput({required this.entepriseId});
}
