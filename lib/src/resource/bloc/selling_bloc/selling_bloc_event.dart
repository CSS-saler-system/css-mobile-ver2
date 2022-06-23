part of 'selling_bloc_bloc.dart';

abstract class SellingBlocEvent extends Equatable {
  const SellingBlocEvent();

  @override
  List<Object> get props => [];
}

class CreateSellingEvent extends SellingBlocEvent {
  final String productId;

  const CreateSellingEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class GetSellingsEvent extends SellingBlocEvent {
  final int page;
  final int pageSize;

  const GetSellingsEvent({required this.page, required this.pageSize});
  @override
  List<Object> get props => [page, pageSize];
}
