// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListProductResponse _$ListProductResponseFromJson(Map<String, dynamic> json) =>
    ListProductResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: json['number'] as int?,
      size: json['size'] as int?,
      totalElement: json['totalElement'] as int?,
      totalPage: json['totalPage'] as int?,
      first: json['first'] as bool?,
      last: json['last'] as bool?,
    );

Map<String, dynamic> _$ListProductResponseToJson(
        ListProductResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'number': instance.number,
      'size': instance.size,
      'totalElement': instance.totalElement,
      'totalPage': instance.totalPage,
      'first': instance.first,
      'last': instance.last,
    };

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      brand: json['brand'] as String?,
      description: json['description'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] == null
          ? null
          : CategoryData.fromJson(json['category'] as Map<String, dynamic>),
      account: json['account'] == null
          ? null
          : AccountData.fromJson(json['account'] as Map<String, dynamic>),
      shortDescription: json['shortDescription'] as String?,
      pointSale: (json['pointSale'] as num?)?.toDouble(),
      productStatus: json['productStatus'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => ProductImageData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand': instance.brand,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'category': instance.category,
      'account': instance.account,
      'shortDescription': instance.shortDescription,
      'pointSale': instance.pointSale,
      'productStatus': instance.productStatus,
      'image': instance.image,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      id: json['id'] as String?,
      categoryName: json['categoryName'] as String?,
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
    };

AccountData _$AccountDataFromJson(Map<String, dynamic> json) => AccountData(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AccountDataToJson(AccountData instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ProductImageData _$ProductImageDataFromJson(Map<String, dynamic> json) =>
    ProductImageData(
      id: json['id'] as int?,
      type: json['type'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$ProductImageDataToJson(ProductImageData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'path': instance.path,
    };
