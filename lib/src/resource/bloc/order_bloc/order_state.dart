part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class CreateOrderLoading extends OrderState {}

class CreateOrderLoaded extends OrderState {
  final String orderId;

  const CreateOrderLoaded({required this.orderId});
  @override
  List<Object> get props => [orderId];
}

class CreateOrderError extends OrderState {
  final Failure failure;

  const CreateOrderError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class GetOrdersLoading extends OrderState {}

class GetOrdersLoaded extends OrderState {
  final GetOrders orders;

  const GetOrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class GetOrdersFail extends OrderState {
  final Failure failure;

  const GetOrdersFail({required this.failure});

  @override
  List<Object> get props => [failure];
}

class GetOrderDetailLoading extends OrderState {}

class GetOrderDetailLoaded extends OrderState {
  final OrderObject orderData;

  const GetOrderDetailLoaded({required this.orderData});
  @override
  List<Object> get props => [orderData];
}

class GetOrderDetailError extends OrderState {
  final Failure failure;

  const GetOrderDetailError({required this.failure});

  @override
  List<Object> get props => [failure];
}
