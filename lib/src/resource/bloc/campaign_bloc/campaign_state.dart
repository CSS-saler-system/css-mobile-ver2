part of 'campaign_bloc.dart';

abstract class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

class CampaignInitial extends CampaignState {}

class GetCampaignsLoading extends CampaignState {}

class GetCampaignsLoaded extends CampaignState {
  final CapmpaignsResponse response;

  const GetCampaignsLoaded({required this.response});

  @override
  List<Object> get props => [response];
}

class GetCampaignsError extends CampaignState {
  final Failure failure;

  const GetCampaignsError({required this.failure});
}
