part of 'order_bloc.dart';



abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  final String productId;
  final String customerId;
  final String address;
  final String phoneNumber;
  final int quantity;
  final List<OD.ProductOrder> productOrder;

  const CreateOrderEvent({
    required this.productId,
    required this.customerId,
    required this.phoneNumber,
    required this.address,
    required this.quantity,
    required this.productOrder,
  });

  @override
  List<Object> get props =>
      [productId, customerId, address, phoneNumber, quantity];
}

class GetOrdersEvent extends OrderEvent {}

class GetOrderDetailEvent extends OrderEvent {
  final String orderId;

  const GetOrderDetailEvent({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
