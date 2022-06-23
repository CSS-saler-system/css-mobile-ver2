// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_sellings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellingResponse _$SellingResponseFromJson(Map<String, dynamic> json) =>
    SellingResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SellingData.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: json['number'] as int?,
      size: json['size'] as int?,
      totalPage: json['totalPage'] as int?,
    );

Map<String, dynamic> _$SellingResponseToJson(SellingResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'number': instance.number,
      'size': instance.size,
      'totalPage': instance.totalPage,
    };

SellingData _$SellingDataFromJson(Map<String, dynamic> json) => SellingData(
      id: json['id'] as String?,
      dateTimeRequest: json['dateTimeRequest'] as String?,
      requestStatus: json['requestStatus'] as String?,
      quantityProduct: json['quantityProduct'] as int?,
      product: json['product'] == null
          ? null
          : ProductSelling.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellingDataToJson(SellingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateTimeRequest': instance.dateTimeRequest,
      'requestStatus': instance.requestStatus,
      'quantityProduct': instance.quantityProduct,
      'product': instance.product,
    };

ProductSelling _$ProductSellingFromJson(Map<String, dynamic> json) =>
    ProductSelling(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      quantityInStock: (json['quantityInStock'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      pointSale: (json['pointSale'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductSellingToJson(ProductSelling instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'quantityInStock': instance.quantityInStock,
      'price': instance.price,
      'pointSale': instance.pointSale,
    };
