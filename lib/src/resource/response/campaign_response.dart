import 'package:json_annotation/json_annotation.dart';

part 'campaign_response.g.dart';

@JsonSerializable()
class CapmpaignsResponse {
  final List<CampaignData>? data;

  const CapmpaignsResponse({this.data});

  factory CapmpaignsResponse.fromJson(Map<String, dynamic> json) =>
      _$CapmpaignsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CapmpaignsResponseToJson(this);
}

@JsonSerializable()
class CampaignData {
  final String? id;
  final String? name;
  final String? campaignShortDescription;
  final String? campaignDescription;
  final int? kpiSaleProduct;

  const CampaignData({
    this.campaignDescription,
    this.id,
    this.kpiSaleProduct,
    this.campaignShortDescription,
    this.name,
  });

  factory CampaignData.fromJson(Map<String, dynamic> json) =>
      _$CampaignDataFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDataToJson(this);
}
