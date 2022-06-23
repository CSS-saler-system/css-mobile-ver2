import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'base_usecase.dart';

class CreateSellingUseCase
    extends BaseUseCase<CreateUseCaseInput, Either<Failure, String>> {
  final ProductRepository _repository;

  CreateSellingUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(CreateUseCaseInput input) async {
    return await _repository.createSelling(input.productId);
  }
}

class CreateUseCaseInput {
  final String productId;

  const CreateUseCaseInput({required this.productId});
}
