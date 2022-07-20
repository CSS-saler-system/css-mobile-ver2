// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enteprise_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListEnteprise _$ListEntepriseFromJson(Map<String, dynamic> json) =>
    ListEnteprise(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => EntepriseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: json['number'] as int?,
      size: json['size'] as int?,
    );

Map<String, dynamic> _$ListEntepriseToJson(ListEnteprise instance) =>
    <String, dynamic>{
      'number': instance.number,
      'size': instance.size,
      'data': instance.data,
    };

EntepriseData _$EntepriseDataFromJson(Map<String, dynamic> json) =>
    EntepriseData(
      address: json['address'] as String?,
      avatars: json['avatars'] == null
          ? null
          : AvatarEnteprise.fromJson(json['avatars'] as Map<String, dynamic>),
      description: json['description'] as String?,
      dob: json['dob'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String?,
      idCard: json['idCard'] == null
          ? null
          : IdCardEnteprise.fromJson(json['idCard'] as Map<String, dynamic>),
      licenses: json['licenses'] == null
          ? null
          : LicensesEnteprise.fromJson(
              json['licenses'] as Map<String, dynamic>),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      quantityCollaborator: json['quantityCollaborator'] as int?,
    );

Map<String, dynamic> _$EntepriseDataToJson(EntepriseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'description': instance.description,
      'quantityCollaborator': instance.quantityCollaborator,
      'dob': instance.dob,
      'avatars': instance.avatars,
      'licenses': instance.licenses,
      'idCard': instance.idCard,
    };

AvatarEnteprise _$AvatarEntepriseFromJson(Map<String, dynamic> json) =>
    AvatarEnteprise(
      account_image_type: json['account_image_type'] as String?,
      id: json['id'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$AvatarEntepriseToJson(AvatarEnteprise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_image_type': instance.account_image_type,
      'path': instance.path,
    };

LicensesEnteprise _$LicensesEntepriseFromJson(Map<String, dynamic> json) =>
    LicensesEnteprise(
      account_image_type: json['account_image_type'] as String?,
      id: json['id'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$LicensesEntepriseToJson(LicensesEnteprise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_image_type': instance.account_image_type,
      'path': instance.path,
    };

IdCardEnteprise _$IdCardEntepriseFromJson(Map<String, dynamic> json) =>
    IdCardEnteprise(
      account_image_type: json['account_image_type'] as String?,
      id: json['id'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$IdCardEntepriseToJson(IdCardEnteprise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_image_type': instance.account_image_type,
      'path': instance.path,
    };
