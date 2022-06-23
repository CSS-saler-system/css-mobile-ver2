import 'package:json_annotation/json_annotation.dart';

part 'get_sellings_response.g.dart';

@JsonSerializable()
class SellingResponse {
  final List<SellingData>? data;
  final int? number;
  final int? size;
  final int? totalPage;

  const SellingResponse({
    this.data,
    this.number,
    this.size,
    this.totalPage,
  });

  factory SellingResponse.fromJson(Map<String, dynamic> json) =>
      _$SellingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SellingResponseToJson(this);
}

@JsonSerializable()
class SellingData {
  final String? id;
  final String? dateTimeRequest;
  final String? requestStatus;
  final int? quantityProduct;
  final ProductSelling? product;

  const SellingData({
    this.id,
    this.dateTimeRequest,
    this.requestStatus,
    this.quantityProduct,
    this.product,
  });

  factory SellingData.fromJson(Map<String, dynamic> json) =>
      _$SellingDataFromJson(json);

  Map<String, dynamic> toJson() => _$SellingDataToJson(this);
}

@JsonSerializable()
class ProductSelling {
  final String? id;
  final String? name;
  final String? description;
  final double? quantityInStock;
  final double? price;
  final double? pointSale;

  const ProductSelling({
    this.id,
    this.name,
    this.description,
    this.quantityInStock,
    this.price,
    this.pointSale,
  });
  factory ProductSelling.fromJson(Map<String, dynamic> json) =>
      _$ProductSellingFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSellingToJson(this);
}
