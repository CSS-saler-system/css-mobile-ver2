part of 'update_customer_bloc_bloc.dart';

abstract class UpdateCustomerBlocState extends Equatable {
  const UpdateCustomerBlocState();

  @override
  List<Object> get props => [];
}

class UpdateCustomerBlocInitial extends UpdateCustomerBlocState {}

class UpdateCustomerLoading extends UpdateCustomerBlocState {}

class UpdateCustomerLoaded extends UpdateCustomerBlocState {
  final bool result;

  const UpdateCustomerLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class UpdateCustomerError extends UpdateCustomerBlocState {
  final Failure failure;

  const UpdateCustomerError({required this.failure});

  @override
  List<Object> get props => [failure];
}
