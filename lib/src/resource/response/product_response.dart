import 'package:flutter_application_1/src/resource/response/paginate_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ListProductResponse {
  final List<ProductData>? data;
  final int? number;
  final int? size;
  final int? totalElement;
  final int? totalPage;
  final bool? first;
  final bool? last;

  const ListProductResponse({
    this.data,
    this.number,
    this.size,
    this.totalElement,
    this.totalPage,
    this.first,
    this.last,
  });

  factory ListProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ListProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListProductResponseToJson(this);
}

@JsonSerializable()
class ProductData {
  final String? id;
  final String? name;
  final String? brand;
  final String? description;
  final double? quantity;
  final double? price;
  final CategoryData? category;
  final AccountData? account;
  final String? shortDescription;
  final double? pointSale;
  final String? productStatus;
  final List<ProductImageData>? image;

  const ProductData({
    this.id,
    this.name,
    this.brand,
    this.description,
    this.quantity,
    this.price,
    this.category,
    this.account,
    this.shortDescription,
    this.pointSale,
    this.productStatus,
    this.image,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}

@JsonSerializable()
class CategoryData {
  final String? id;
  final String? categoryName;

  const CategoryData({
    this.id,
    this.categoryName,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}

@JsonSerializable()
class AccountData {
  final String? id;

  const AccountData({
    this.id,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) =>
      _$AccountDataFromJson(json);
  Map<String, dynamic> toJson() => _$AccountDataToJson(this);
}

@JsonSerializable()
class ProductImageData {
  final int? id;
  final String? type;
  final String? path;

  const ProductImageData({
    this.id,
    this.type,
    this.path,
  });

  factory ProductImageData.fromJson(Map<String, dynamic> json) =>
      _$ProductImageDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageDataToJson(this);
}
