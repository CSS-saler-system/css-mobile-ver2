import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/response/enteprise_response.dart';
import 'package:flutter_application_1/src/resource/usecase/get_list_enteprise_usecase.dart';

part 'enteprise_event.dart';
part 'enteprise_state.dart';

class EntepriseBloc extends Bloc<EntepriseEvent, EntepriseState> {
  final GetListEntepriseUseCase _listEnterprise;

  EntepriseBloc(this._listEnterprise) : super(EntepriseInitial()) {
    on<GetListEntepriseEvent>(_getListEnteprise);
  }

  FutureOr<void> _getListEnteprise(
      GetListEntepriseEvent event, Emitter<EntepriseState> emit) async {
    emit(GetListEntepriseLoadding());
    (await _listEnterprise.execute(const GetListEntepriseUseCaseInput())).fold(
        (failure) => emit(GetListEntepriseError(failure: failure)),
        (enteprises) => emit(GetListEntepriseLoaded(enteprises: enteprises)));
  }
}
