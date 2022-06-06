// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      jwt_token: json['jwt_token'] as String?,
      phone: json['phone'] as String?,
      role: (json['role'] as List<dynamic>?)
          ?.map((e) => RoleObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'jwt_token': instance.jwt_token,
      'phone': instance.phone,
      'id': instance.id,
      'role': instance.role,
    };

RoleObject _$RoleObjectFromJson(Map<String, dynamic> json) => RoleObject(
      authority: json['authority'] as String?,
    );

Map<String, dynamic> _$RoleObjectToJson(RoleObject instance) =>
    <String, dynamic>{
      'authority': instance.authority,
    };
