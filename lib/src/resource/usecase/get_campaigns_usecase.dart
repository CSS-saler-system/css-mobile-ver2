import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/response/campaign_response.dart';
import 'base_usecase.dart';

class GetCampaignsUseCase extends BaseUseCase<GetCampaginsUseCaseInput,
    Either<Failure, CapmpaignsResponse>> {
  final ProductRepository _repository;

  GetCampaignsUseCase(this._repository);

  @override
  Future<Either<Failure, CapmpaignsResponse>> execute(
      GetCampaginsUseCaseInput input) async {
    return await _repository.getcampagins();
  }
}

class GetCampaginsUseCaseInput {
  const GetCampaginsUseCaseInput();
}
