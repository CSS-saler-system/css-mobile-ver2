import 'package:json_annotation/json_annotation.dart';

part 'enteprise_response.g.dart';

@JsonSerializable()
class ListEnteprise {
  final int? number;
  final int? size;
  final List<EntepriseData>? data;

  const ListEnteprise({this.data, this.number, this.size});

  factory ListEnteprise.fromJson(Map<String, dynamic> json) =>
      _$ListEntepriseFromJson(json);
}

@JsonSerializable()
class EntepriseData {
  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? description;
  final int? quantityCollaborator;
  final String? dob;
  final AvatarEnteprise? avatars;
  final LicensesEnteprise? licenses;
  final IdCardEnteprise? idCard;
  const EntepriseData({
    this.address,
    this.avatars,
    this.description,
    this.dob,
    this.email,
    this.id,
    this.idCard,
    this.licenses,
    this.name,
    this.phone,
    this.quantityCollaborator,
  });

  factory EntepriseData.fromJson(Map<String, dynamic> json) =>
      _$EntepriseDataFromJson(json);
}

@JsonSerializable()
class AvatarEnteprise {
  final String? id;
  final String? account_image_type;
  final String? path;
  const AvatarEnteprise({
    this.account_image_type,
    this.id,
    this.path,
  });

  factory AvatarEnteprise.fromJson(Map<String, dynamic> json) =>
      _$AvatarEntepriseFromJson(json);
}

@JsonSerializable()
class LicensesEnteprise {
  final String? id;
  final String? account_image_type;
  final String? path;

  const LicensesEnteprise({
    this.account_image_type,
    this.id,
    this.path,
  });

  factory LicensesEnteprise.fromJson(Map<String, dynamic> json) =>
      _$LicensesEntepriseFromJson(json);
}

@JsonSerializable()
class IdCardEnteprise {
  final String? id;
  final String? account_image_type;
  final String? path;

  const IdCardEnteprise({
    this.account_image_type,
    this.id,
    this.path,
  });

  factory IdCardEnteprise.fromJson(Map<String, dynamic> json) =>
      _$IdCardEntepriseFromJson(json);
}
