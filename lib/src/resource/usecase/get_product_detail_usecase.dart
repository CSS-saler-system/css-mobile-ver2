import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/auth_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import '../request/get_list_product_request.dart';
import 'base_usecase.dart';

class GetProductDetailUseCase
    extends BaseUseCase<GetProductDetailInput, Either<Failure, ProductData>> {
  final ProductRepository _repository;

  GetProductDetailUseCase(this._repository);

  @override
  Future<Either<Failure, ProductData>> execute(
      GetProductDetailInput input) async {
    return await _repository.getProductDetail(input.productId);
  }
}

class GetProductDetailInput {
  final String productId;

  const GetProductDetailInput({
    required this.productId,
  });
}
