import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/resource/usecase/get_list_customer_usecase.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetCustomersUseCase getCustomersUseCase;

  CustomerBloc(this.getCustomersUseCase) : super(CustomerInitial()) {
    on<CustomerEvent>(_getCustomers);
  }

  FutureOr<void> _getCustomers(
      CustomerEvent event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());

    (await getCustomersUseCase.execute(const GetCustomersUseCaseInput())).fold(
        (failure) => emit(CustomerError(failure: failure)),
        (customers) => emit(CustomersLoaded(customers: customers)));
  }
}
