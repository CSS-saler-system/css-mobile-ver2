import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? jwt_token;
  String? phone;
  String? id;
  List<RoleObject>? role;

  LoginResponse({
    this.jwt_token,
    this.phone,
    this.role,
    this.id,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class RoleObject {
  String? authority;

  RoleObject({
    this.authority,
  });

  factory RoleObject.fromJson(Map<String, dynamic> json) =>
      _$RoleObjectFromJson(json);

  Map<String, dynamic> toJson() => _$RoleObjectToJson(this);
}
