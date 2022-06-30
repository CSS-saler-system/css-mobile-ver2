import 'package:json_annotation/json_annotation.dart';

part 'customer_response.g.dart';

@JsonSerializable()
class CustomerData {
  final String? id;
  final String? name;
  final String? address;
  final String? dob;
  final String? description;
  final String? phone;

  const CustomerData({
    this.id,
    this.name,
    this.address,
    this.dob,
    this.description,
    this.phone,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataToJson(this);
}

@JsonSerializable()
class OrderData {
  final String? id;

  const OrderData({
    this.id,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataToJson(this);
}

@JsonSerializable()
class AccountCreator {
  final String? id;

  const AccountCreator({
    this.id,
  });

  factory AccountCreator.fromJson(Map<String, dynamic> json) =>
      _$AccountCreatorFromJson(json);

  Map<String, dynamic> toJson() => _$AccountCreatorToJson(this);
}
