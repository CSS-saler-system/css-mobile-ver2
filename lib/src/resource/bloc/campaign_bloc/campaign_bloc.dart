import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/response/campaign_response.dart';
import 'package:flutter_application_1/src/resource/usecase/get_campaigns_usecase.dart';

part 'campaign_event.dart';
part 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final GetCampaignsUseCase _campaignsUseCase;

  CampaignBloc(this._campaignsUseCase) : super(CampaignInitial()) {
    on<GetCampaignsEvent>(_getCampaigns);
  }

  FutureOr<void> _getCampaigns(
      GetCampaignsEvent event, Emitter<CampaignState> emit) async {
    emit(GetCampaignsLoading());

    (await _campaignsUseCase.execute(const GetCampaginsUseCaseInput())).fold(
        (failure) => emit(GetCampaignsError(failure: failure)),
        (response) => emit(GetCampaignsLoaded(response: response)));
  }
}
