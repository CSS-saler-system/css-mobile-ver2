part of 'selling_bloc_bloc.dart';

abstract class SellingBlocState extends Equatable {
  const SellingBlocState();

  @override
  List<Object> get props => [];
}

class SellingBlocInitial extends SellingBlocState {}

class CreateSellingLoading extends SellingBlocState {}

class CreateSellingLoaded extends SellingBlocState {
  final String sellingId;

  const CreateSellingLoaded({required this.sellingId});

  @override
  List<Object> get props => [sellingId];
}

class CreateSellingError extends SellingBlocState {
  final Failure failure;

  const CreateSellingError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class GetSellingsLoading extends SellingBlocState {}

class GetSellingsLoaded extends SellingBlocState {
  final SellingResponse sellingResponse;

  const GetSellingsLoaded({required this.sellingResponse});

  @override
  List<Object> get props => [sellingResponse];
}

class GetSellingsError extends SellingBlocState {
  final Failure failure;

  const GetSellingsError({required this.failure});

  @override
  List<Object> get props => [failure];
}
