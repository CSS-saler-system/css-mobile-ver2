part of 'update_customer_bloc_bloc.dart';

abstract class UpdateCustomerBlocEvent extends Equatable {
  const UpdateCustomerBlocEvent();

  @override
  List<Object> get props => [];
}

class UpdateCustomerEvent extends UpdateCustomerBlocEvent {
  final UpdateCustomerInput input;

  const UpdateCustomerEvent(this.input);

  @override
  List<Object> get props => [input];
}
