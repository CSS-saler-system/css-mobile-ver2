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

  const CreateOrderEvent({
    required this.productId,
    required this.customerId,
    required this.phoneNumber,
    required this.address,
    required this.quantity,
  });

  @override
  List<Object> get props =>
      [productId, customerId, address, phoneNumber, quantity];
}
