import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/auth_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/request/get_list_product_enterprise_request.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import '../request/get_list_product_request.dart';
import 'base_usecase.dart';

class GetEntepriseProductsUseCase extends BaseUseCase<
    GetEntepriseProductsUseCaseInput, Either<Failure, ListProductResponse>> {
  final ProductRepository _repository;

  GetEntepriseProductsUseCase(this._repository);

  @override
  Future<Either<Failure, ListProductResponse>> execute(
      GetEntepriseProductsUseCaseInput input) async {
    return await _repository.getListProductEnteprise(
      GetListProductEntepriseRequest(
        id: input.id,
        page: input.page,
        pageSize: input.pageSize,
        status: input.status,
        pointSale: input.pointSale,
        price: input.price,
        inStock: input.inStock,
        brand: input.brand,
        productName: input.productName,
      ),
    );
  }
}

class GetEntepriseProductsUseCaseInput {
  final int? page;
  final int? pageSize;
  final String? status;
  final int? pointSale;
  final String? price;
  final String? inStock;
  final String? brand;
  final String? productName;
  final String id;

  const GetEntepriseProductsUseCaseInput({
    required this.id,
    this.page = 1,
    this.pageSize = 10,
    this.status = "ACTIVE",
    this.pointSale,
    this.price,
    this.inStock,
    this.brand,
    this.productName,
  });
}
