import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/enteprise_repository.dart';
import 'package:flutter_application_1/src/resource/response/enteprise_response.dart';
import 'base_usecase.dart';

class GetListEntepriseUseCase extends BaseUseCase<GetListEntepriseUseCaseInput,
    Either<Failure, List<EntepriseData>>> {
  final EntepriseRepository _repository;

  GetListEntepriseUseCase(this._repository);

  @override
  Future<Either<Failure, List<EntepriseData>>> execute(
      GetListEntepriseUseCaseInput input) async {
    return await _repository.getAllEnteprise();
  }
}

class GetListEntepriseUseCaseInput {
  const GetListEntepriseUseCaseInput();
}
