part of 'get_products_bloc.dart';

abstract class GetProductsEvent extends Equatable {
  const GetProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEventGet extends GetProductsEvent {
  final GetListProductRequest request;

  const GetProductsEventGet({required this.request});

  @override
  List<Object> get props => [request];
}

class GetProductsLoadMoreEvent extends GetProductsEvent {
  final GetListProductRequest request;

  const GetProductsLoadMoreEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class GetProductDetailEvent extends GetProductsEvent {
  final String productId;

  const GetProductDetailEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class GetEntepriseProductsEvent extends GetProductsEvent {
  final GetEntepriseProductsUseCaseInput request;

  const GetEntepriseProductsEvent({required this.request});

  @override
  List<Object> get props => [request];
}
