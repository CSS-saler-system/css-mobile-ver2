import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? jwt_token;
  String? phone;
  List<RoleObject>? role;

  LoginResponse({
    this.jwt_token,
    this.phone,
    this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class RoleObject{
  String? authority;

  RoleObject({
    this.authority,
  });

  factory RoleObject.fromJson(Map<String, dynamic> json) => _$RoleObjectFromJson(json);

  Map<String, dynamic> toJson() => _$RoleObjectToJson(this);
}