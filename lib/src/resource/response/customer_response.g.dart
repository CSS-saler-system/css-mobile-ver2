// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) => CustomerData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      dob: json['dob'] as String?,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$CustomerDataToJson(CustomerData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'dob': instance.dob,
      'description': instance.description,
      'phone': instance.phone,
    };

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'id': instance.id,
    };

AccountCreator _$AccountCreatorFromJson(Map<String, dynamic> json) =>
    AccountCreator(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AccountCreatorToJson(AccountCreator instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
