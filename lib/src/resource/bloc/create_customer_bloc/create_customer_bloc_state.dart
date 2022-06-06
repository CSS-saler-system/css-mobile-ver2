part of 'create_customer_bloc_bloc.dart';

abstract class CreateCustomerBlocState extends Equatable {
  const CreateCustomerBlocState();

  @override
  List<Object> get props => [];
}

class CreateCustomerBlocInitial extends CreateCustomerBlocState {}

class CreateCustomerBlocLoading extends CreateCustomerBlocState {}

class CreateCustomerSuccess extends CreateCustomerBlocState {
  final String customerId;

  const CreateCustomerSuccess(this.customerId);

  @override
  List<Object> get props => [customerId];
}

class CreateCustomerFailure extends CreateCustomerBlocState {
  final Failure failure;

  const CreateCustomerFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
