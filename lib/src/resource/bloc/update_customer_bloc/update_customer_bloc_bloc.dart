import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/usecase/update_customer_usecase.dart';

part 'update_customer_bloc_event.dart';
part 'update_customer_bloc_state.dart';

class UpdateCustomerBlocBloc
    extends Bloc<UpdateCustomerBlocEvent, UpdateCustomerBlocState> {
  final UpdateCustomerUseCase updateCustomerUseCase;

  UpdateCustomerBlocBloc(this.updateCustomerUseCase)
      : super(UpdateCustomerBlocInitial()) {
    on<UpdateCustomerEvent>(_handleUpdateCustomer);
  }

  FutureOr<void> _handleUpdateCustomer(
      UpdateCustomerEvent event, Emitter<UpdateCustomerBlocState> emit) async {
    emit(UpdateCustomerLoading());

    (await updateCustomerUseCase.execute(event.input)).fold(
      (failure) => emit(UpdateCustomerError(failure: failure)),
      (result) => emit(UpdateCustomerLoaded(result: result)),
    );
  }
}
