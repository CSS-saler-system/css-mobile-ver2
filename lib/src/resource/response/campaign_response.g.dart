// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapmpaignsResponse _$CapmpaignsResponseFromJson(Map<String, dynamic> json) =>
    CapmpaignsResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CampaignData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CapmpaignsResponseToJson(CapmpaignsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CampaignData _$CampaignDataFromJson(Map<String, dynamic> json) => CampaignData(
      campaignDescription: json['campaignDescription'] as String?,
      id: json['id'] as String?,
      kpiSaleProduct: json['kpiSaleProduct'] as int?,
      campaignShortDescription: json['campaignShortDescription'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CampaignDataToJson(CampaignData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'campaignShortDescription': instance.campaignShortDescription,
      'campaignDescription': instance.campaignDescription,
      'kpiSaleProduct': instance.kpiSaleProduct,
    };
