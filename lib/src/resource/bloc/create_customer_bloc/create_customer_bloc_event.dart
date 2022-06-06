part of 'create_customer_bloc_bloc.dart';

abstract class CreateCustomerBlocEvent extends Equatable {
  const CreateCustomerBlocEvent();

  @override
  List<Object> get props => [];
}

class CreateCustomerOnPressed extends CreateCustomerBlocEvent {
  final CreateCustomerInput input;

  const CreateCustomerOnPressed(this.input);

  @override
  List<Object> get props => [input];
}
