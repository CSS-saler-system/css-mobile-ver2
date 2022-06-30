import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/usecase/create_customer_usecase.dart';

part 'create_customer_bloc_event.dart';
part 'create_customer_bloc_state.dart';

class CreateCustomerBlocBloc
    extends Bloc<CreateCustomerBlocEvent, CreateCustomerBlocState> {
  final CreateCustomerUseCase _createCustomerUsecase;

  CreateCustomerBlocBloc(this._createCustomerUsecase)
      : super(CreateCustomerBlocInitial()) {
    on<CreateCustomerOnPressed>(_onCreateCustomer);
  }

  FutureOr<void> _onCreateCustomer(CreateCustomerOnPressed event,
      Emitter<CreateCustomerBlocState> emit) async {
    emit(CreateCustomerBlocLoading());

    (await _createCustomerUsecase.execute(event.input)).fold(
      (failure) => emit(CreateCustomerFailure(failure)),
      (customerId) => emit(CreateCustomerSuccess(customerId)),
    );
  }
}
