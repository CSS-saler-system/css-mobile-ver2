part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class GetListCustomer extends CustomerEvent {
  const GetListCustomer();

  @override
  List<Object> get props => [];
}
