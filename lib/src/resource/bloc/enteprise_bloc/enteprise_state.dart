part of 'enteprise_bloc.dart';

abstract class EntepriseState extends Equatable {
  const EntepriseState();

  @override
  List<Object> get props => [];
}
class EntepriseInitial extends EntepriseState{}

class GetListEntepriseLoadding extends EntepriseState {}

class GetListEntepriseLoaded extends EntepriseState {
  final List<EntepriseData> enteprises;

  const GetListEntepriseLoaded({required this.enteprises});

  @override
  List<Object> get props => [enteprises];
}

class GetListEntepriseError extends EntepriseState {
  final Failure failure;

  const GetListEntepriseError({required this.failure});
}
