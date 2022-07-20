class GetListProductEntepriseRequest {
  final int? page;
  final int? pageSize;
  final String? status;
  final int? pointSale;
  final String? price;
  final String? inStock;
  final String? brand;
  final String? productName;
  final String id;

  const GetListProductEntepriseRequest({
    required this.id,
    this.page,
    this.pageSize,
    this.status,
    this.pointSale,
    this.price,
    this.inStock,
    this.brand,
    this.productName,
  });
}
