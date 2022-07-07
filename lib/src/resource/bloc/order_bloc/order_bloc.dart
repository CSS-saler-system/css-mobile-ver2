import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/resource/usecase/create_order_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_order_detail_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_orders_usecase.dart';

import '../../response/order_response.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUsecase _createOrderUsecase;
  final GetOrdersUseCase _getOrdersUseCase;
  final GetOrderDetailUseCase _getOrderDetailUseCase;

  OrderBloc(this._createOrderUsecase, this._getOrdersUseCase,
      this._getOrderDetailUseCase)
      : super(OrderInitial()) {
    on<CreateOrderEvent>(_createOrder);
    on<GetOrdersEvent>(_getOrders);
    on<GetOrderDetailEvent>(_getOrderDetail);
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

  FutureOr<void> _getOrders(
      GetOrdersEvent event, Emitter<OrderState> emit) async {
    emit(GetOrdersLoading());

    (await _getOrdersUseCase.execute(const GetOrderUseCaseInput())).fold(
        (failure) => emit(GetOrdersFail(failure: failure)),
        (orders) => emit(GetOrdersLoaded(orders: orders)));
  }

  FutureOr<void> _getOrderDetail(
      GetOrderDetailEvent event, Emitter<OrderState> emit) async {
    emit(GetOrderDetailLoading());

    (await _getOrderDetailUseCase
            .execute(GetOrderDetailUseCaseInput(orderId: event.orderId)))
        .fold((failure) => emit(GetOrderDetailError(failure: failure)),
            (orderData) => emit(GetOrderDetailLoaded(orderData: orderData)));
  }
}
