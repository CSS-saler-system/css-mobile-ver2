class GetListProductRequest {
  final int? page;
  final int? pageSize;
  final String? status;
  final int? pointSale;
  final String? price;
  final String? inStock;
  final String? brand;
  final String? productName;

  const GetListProductRequest({
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
