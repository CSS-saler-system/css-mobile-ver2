import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/response/get_sellings_response.dart';
import 'package:flutter_application_1/src/resource/usecase/create_selling_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_sellings_usecase.dart';

part 'selling_bloc_event.dart';
part 'selling_bloc_state.dart';

class SellingBlocBloc extends Bloc<SellingBlocEvent, SellingBlocState> {
  final CreateSellingUseCase _createSellingUseCase;
  final GetSellingsUseCase _getSellingsUseCase;

  SellingBlocBloc(this._createSellingUseCase, this._getSellingsUseCase)
      : super(SellingBlocInitial()) {
    on<CreateSellingEvent>(_createSelling);
    on<GetSellingsEvent>(_getSellings);
  }
  FutureOr<void> _createSelling(
      CreateSellingEvent event, Emitter<SellingBlocState> emit) async {
    emit(CreateSellingLoading());

    (await _createSellingUseCase
            .execute(CreateUseCaseInput(productId: event.productId)))
        .fold((failure) => emit(CreateSellingError(failure: failure)),
            (sellingId) => emit(CreateSellingLoaded(sellingId: sellingId)));
  }

  FutureOr<void> _getSellings(
      GetSellingsEvent event, Emitter<SellingBlocState> emit) async {
    emit(GetSellingsLoading());
    (await _getSellingsUseCase.execute(GetSellingsUseCaseInput(
            page: event.page, pageSize: event.pageSize)))
        .fold(
            (failure) => emit(CreateSellingError(failure: failure)),
            (sellingResponse) =>
                emit(GetSellingsLoaded(sellingResponse: sellingResponse)));
  }
}
