import 'package:json_annotation/json_annotation.dart';

part 'order_response.g.dart';

@JsonSerializable()
class GetOrders {
  final List<OrderObject>? data;

  const GetOrders({
    this.data,
  });

  factory GetOrders.fromJson(Map<String, dynamic> json) =>
      _$GetOrdersFromJson(json);
}

@JsonSerializable()
class OrderObject {
  final String? id;
  final String? createDate;
  final double? totalPrice;
  final double? totalPointSale;
  final String? customerName;
  final String? deliveryPhone;
  final String? deliveryAddress;
  final List<ProductOrder>? orderDetails;
  final AccountOrder? account;
  final CustomerOrder? customer;
  final String? status;

  const OrderObject({
    this.id,
    this.createDate,
    this.totalPrice,
    this.customerName,
    this.deliveryAddress,
    this.deliveryPhone,
    this.totalPointSale,
    this.account,
    this.customer,
    this.orderDetails,
    this.status,
  });

  factory OrderObject.fromJson(Map<String, dynamic> json) =>
      _$OrderObjectFromJson(json);
}

@JsonSerializable()
class ProductOrder {
  final String? id;
  final String? nameProduct;
  final double? productPrice;
  final double? quantity;
  final double? totalPriceProduct;

  const ProductOrder({
    this.id,
    this.nameProduct,
    this.productPrice,
    this.quantity,
    this.totalPriceProduct,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderFromJson(json);
}

@JsonSerializable()
class AccountOrder {
  final String? id;
  final String? name;
  final String? phone;

  const AccountOrder({
    this.id,
    this.name,
    this.phone,
  });

  factory AccountOrder.fromJson(Map<String, dynamic> json) =>
      _$AccountOrderFromJson(json);
}

@JsonSerializable()
class CustomerOrder {
  final String? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? description;

  const CustomerOrder({
    this.id,
    this.name,
    this.phone,
    this.description,
    this.address,
  });

  factory CustomerOrder.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderFromJson(json);
}
