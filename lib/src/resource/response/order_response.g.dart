// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrders _$GetOrdersFromJson(Map<String, dynamic> json) => GetOrders(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetOrdersToJson(GetOrders instance) => <String, dynamic>{
      'data': instance.data,
    };

OrderObject _$OrderObjectFromJson(Map<String, dynamic> json) => OrderObject(
      id: json['id'] as String?,
      createDate: json['createDate'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      customerName: json['customerName'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      deliveryPhone: json['deliveryPhone'] as String?,
      totalPointSale: (json['totalPointSale'] as num?)?.toDouble(),
      account: json['account'] == null
          ? null
          : AccountOrder.fromJson(json['account'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : CustomerOrder.fromJson(json['customer'] as Map<String, dynamic>),
      orderDetails: (json['orderDetails'] as List<dynamic>?)
          ?.map((e) => ProductOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderObjectToJson(OrderObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate,
      'totalPrice': instance.totalPrice,
      'totalPointSale': instance.totalPointSale,
      'customerName': instance.customerName,
      'deliveryPhone': instance.deliveryPhone,
      'deliveryAddress': instance.deliveryAddress,
      'orderDetails': instance.orderDetails,
      'account': instance.account,
      'customer': instance.customer,
      'status': instance.status,
    };

ProductOrder _$ProductOrderFromJson(Map<String, dynamic> json) => ProductOrder(
      id: json['id'] as String?,
      nameProduct: json['nameProduct'] as String?,
      productPrice: (json['productPrice'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      totalPriceProduct: (json['totalPriceProduct'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductOrderToJson(ProductOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameProduct': instance.nameProduct,
      'productPrice': instance.productPrice,
      'quantity': instance.quantity,
      'totalPriceProduct': instance.totalPriceProduct,
    };

AccountOrder _$AccountOrderFromJson(Map<String, dynamic> json) => AccountOrder(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$AccountOrderToJson(AccountOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };

CustomerOrder _$CustomerOrderFromJson(Map<String, dynamic> json) =>
    CustomerOrder(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$CustomerOrderToJson(CustomerOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'description': instance.description,
    };
