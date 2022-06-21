import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/resource/usecase/get_customer_detail_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_list_customer_usecase.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetCustomersUseCase getCustomersUseCase;
  final GetCustomerDetailUseCase getCustomerDetailUseCase;

  CustomerBloc(this.getCustomersUseCase, this.getCustomerDetailUseCase)
      : super(CustomerInitial()) {
    on<GetListCustomer>(_getCustomers);
    on<GetCustomerDetailEvent>(_getCustomerDetail);
  }

  FutureOr<void> _getCustomers(
      GetListCustomer event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());

    (await getCustomersUseCase.execute(const GetCustomersUseCaseInput())).fold(
        (failure) => emit(CustomerError(failure: failure)),
        (customers) => emit(CustomersLoaded(customers: customers)));
  }

  FutureOr<void> _getCustomerDetail(
      GetCustomerDetailEvent event, Emitter<CustomerState> emit) async {
    emit(GetCustomerDetailLoading());

    (await getCustomerDetailUseCase
            .execute(GetCustomerDetailInput(customerId: event.customerId)))
        .fold((failure) => emit(GetCustomerDetailError(failure: failure)),
            (customer) => emit(GetCustomerDetailLoaded(customer: customer)));
  }
}
