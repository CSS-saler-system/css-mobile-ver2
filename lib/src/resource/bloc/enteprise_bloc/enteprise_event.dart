part of 'enteprise_bloc.dart';

abstract class EntepriseEvent extends Equatable {
  const EntepriseEvent();

  @override
  List<Object> get props => [];
}

class GetListEntepriseEvent extends EntepriseEvent {}
