import 'package:either_dart/either.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/repository/auth_reponsitory.dart';
import 'package:flutter_application_1/src/resource/repository/product_repository.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import '../request/get_list_product_request.dart';
import 'base_usecase.dart';

class GetProductsUseCase extends BaseUseCase<GetProductsUseCaseInput,
    Either<Failure, ListProductResponse>> {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  @override
  Future<Either<Failure, ListProductResponse>> execute(
      GetProductsUseCaseInput input) async {
    return await _repository.getListProduct(
      GetListProductRequest(
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

class GetProductsUseCaseInput {
  final int? page;
  final int? pageSize;
  final String? status;
  final int? pointSale;
  final String? price;
  final String? inStock;
  final String? brand;
  final String? productName;

  const GetProductsUseCaseInput({
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
