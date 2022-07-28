import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/src/resource/data/failure.dart';
import 'package:flutter_application_1/src/resource/request/get_list_product_request.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:flutter_application_1/src/resource/usecase/get_enteprise_products_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_product_detail_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/get_products_usecase.dart';
import 'package:flutter_application_1/src/resource/usecase/list_product_not_registed.dart';
import 'package:flutter_application_1/src/resource/usecase/list_product_registed.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final GetProductsUseCase _useCase;
  final GetProductDetailUseCase _detailUseCase;
  final GetEntepriseProductsUseCase _entepriseProductsUseCase;
  final GetProductNotRegistedUseCase _notRegistedUseCase;
  final GetProductRegistedUseCase _registedUseCase;

  GetProductsBloc(
    this._useCase,
    this._detailUseCase,
    this._entepriseProductsUseCase,
    this._notRegistedUseCase,
    this._registedUseCase,
  ) : super(GetProductsInitial()) {
    on<GetProductsEventGet>(_getProducts);
    on<GetProductsLoadMoreEvent>(_onLoadMore);
    on<GetProductDetailEvent>(_getProductDetail);
    on<GetEntepriseProductsEvent>(_getEntepriseProducts);
    on<GetProductsNotReqistedEvent>(_getProductNotRegisted);
    on<GetProductsReqistedEvent>(_getProductRegisted);
  }

  FutureOr<void> _getProducts(
      GetProductsEventGet event, Emitter<GetProductsState> emit) async {
    emit(GetProductsLoading());

    (await _useCase.execute(GetProductsUseCaseInput(
      page: event.request.page,
      pageSize: event.request.pageSize,
      status: event.request.status,
      pointSale: event.request.pointSale,
      price: event.request.price,
      inStock: event.request.inStock,
      brand: event.request.brand,
      productName: event.request.productName,
    )))
        .fold((failure) => emit(GetProductsError(failure: failure)),
            (response) => emit(GetProductsLoaded(response: response)));
  }

  Future<void> _onLoadMore(
      GetProductsLoadMoreEvent event, Emitter<GetProductsState> emit) async {
    (await _useCase.execute(GetProductsUseCaseInput(
      page: event.request.page,
      pageSize: event.request.pageSize,
      status: event.request.status,
      pointSale: event.request.pointSale,
      price: event.request.price,
      inStock: event.request.inStock,
      brand: event.request.brand,
      productName: event.request.productName,
    )))
        .fold(
            (failure) => emit(GetProductsLoadMoreError(failure: failure)),
            (response) =>
                emit(GetProductsLoadMoreLoaded(products: response.data ?? [])));
  }

  FutureOr<void> _getProductDetail(
      GetProductDetailEvent event, Emitter<GetProductsState> emit) async {
    emit(GetProductDetailLoading());

    (await _detailUseCase.execute(GetProductDetailInput(
      productId: event.productId,
    )))
        .fold((failure) => emit(GetProductDetailError(failure: failure)),
            (response) => emit(GetProductDetailLoaded(product: response)));
  }

  FutureOr<void> _getEntepriseProducts(
      GetEntepriseProductsEvent event, Emitter<GetProductsState> emit) async {
    (await _entepriseProductsUseCase.execute(event.request)).fold(
        (failure) => emit(GetProductsError(failure: failure)),
        (response) => emit(GetProductsLoaded(response: response)));
  }

  FutureOr<void> _getProductNotRegisted(
      GetProductsNotReqistedEvent event, Emitter<GetProductsState> emit) async {
    (await _notRegistedUseCase.execute(
            GetProductNotRegistedUseCaseInput(entepriseId: event.enteprieseId)))
        .fold((failure) => emit(GetProductsError(failure: failure)),
            (response) => emit(GetProductsLoaded(response: response)));
  }

  FutureOr<void> _getProductRegisted(
      GetProductsReqistedEvent event, Emitter<GetProductsState> emit) async {
    (await _registedUseCase.execute(
            GetProductRegistedUseCaseInput(entepriseId: event.enteprieseId)))
        .fold((failure) => emit(GetProductsError(failure: failure)),
            (response) => emit(GetProductsLoaded(response: response)));
  }
}
