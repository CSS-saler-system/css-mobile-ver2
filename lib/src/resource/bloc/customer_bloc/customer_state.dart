part of 'customer_bloc.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomersLoaded extends CustomerState {
  final List<CustomerData> customers;

  const CustomersLoaded({required this.customers});
}

class CustomerError extends CustomerState {
  final Failure failure;

  const CustomerError({required this.failure});
}
