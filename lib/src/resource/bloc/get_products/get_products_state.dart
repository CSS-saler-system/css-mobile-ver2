part of 'get_products_bloc.dart';

abstract class GetProductsState extends Equatable {
  const GetProductsState();

  @override
  List<Object> get props => [];
}

class GetProductsInitial extends GetProductsState {}

class GetProductsLoading extends GetProductsState {}

class GetProductsLoaded extends GetProductsState {
  final ListProductResponse response;

  const GetProductsLoaded({required this.response});
}

class GetProductsError extends GetProductsState {
  final Failure failure;
  const GetProductsError({required this.failure});
}

class GetProductsLoadMoreLoaded extends GetProductsState {
  final List<ProductData> products;

  const GetProductsLoadMoreLoaded({required this.products});
}

class GetProductsHasLoadMore extends GetProductsState {}

class GetProductsNoLoadMore extends GetProductsState {}

class GetProductsLoadMoreError extends GetProductsState {
  final Failure failure;
  const GetProductsLoadMoreError({required this.failure});
}

class GetProductDetailLoading extends GetProductsState {}

class GetProductDetailLoaded extends GetProductsState {
  final ProductData product;

  const GetProductDetailLoaded({required this.product});
}

class GetProductDetailError extends GetProductsState {
  final Failure failure;
  const GetProductDetailError({required this.failure});
}
