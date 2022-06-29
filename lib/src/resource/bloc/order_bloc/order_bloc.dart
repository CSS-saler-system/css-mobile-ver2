import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/usecase/create_order_usecase.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUsecase _createOrderUsecase;

  OrderBloc(this._createOrderUsecase) : super(OrderInitial()) {
    on<CreateOrderEvent>(_createOrder);
  }

  FutureOr<void> _createOrder(
      CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(CreateOrderLoading());

    (await _createOrderUsecase.execute(
      CreateOrderInput(
        productId: event.productId,
        customerId: event.customerId,
        phoneNumber: event.phoneNumber,
        address: event.address,
        quantity: event.quantity,
      ),
    ))
        .fold((failure) => emit(CreateOrderError(failure: failure)),
            (orderId) => emit(CreateOrderLoaded(orderId: orderId)));
  }
}
