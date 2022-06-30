import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/button_error.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/action_header.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/campings.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/list_brands.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/populars_product.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/sell_today_product.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/request/get_list_product_request.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GetProductsBloc _getProductsBloc = getIt<GetProductsBloc>();
  final List<ProductData> productSell = [];
  bool _loadMore = false;
  int _page = 1, _pageSize = 8, _totalPage = 0;

  @override
  void initState() {
    super.initState();

    _getProductsBloc.add(GetProductsEventGet(
        request: GetListProductRequest(page: 1, pageSize: _pageSize)));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _loadMore = _page < _totalPage ? true : false;
        });

        if (_loadMore) {
          _getProductsBloc.add(GetProductsLoadMoreEvent(
              request:
                  GetListProductRequest(page: _page + 1, pageSize: _pageSize)));
          _page++;
          log('page ${_page}');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: Column(children: [
        const HomeHeaderAction(),
        const SizedBox(height: 20),
        Expanded(
            child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Campings(),
            // const SizedBox(height: 20),
            // const PopularProducts(),
            const SizedBox(height: 20),
            _buildSellProducts(),
            const SizedBox(height: 10),
            _loadMore
                ? const Center(
                    child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator()))
                : const SizedBox(),
          ]),
        ))
      ]),
    );
  }

  Widget _buildSellProducts() {
    return BlocProvider(
      create: (context) => _getProductsBloc,
      child: Flexible(
        child: BlocListener<GetProductsBloc, GetProductsState>(
          listener: (context, state) {
            if (state is GetProductsLoaded) {
              productSell.addAll(state.response.data ?? []);
              _totalPage = state.response.totalPage ?? 0;
            }

            if (state is GetProductsLoadMoreLoaded) {
              productSell.addAll(state.products);

              setState(() {
                _loadMore = false;
              });
            }
          },
          child: BlocBuilder<GetProductsBloc, GetProductsState>(
            builder: (context, state) {
              if (state is GetProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetProductsLoaded ||
                  state is GetProductsLoadMoreLoaded) {
                return SellTodayProducts(products: productSell);
              }

              return Center(
                  child: ButtonError(
                      onPressed: () => _getProductsBloc.add(GetProductsEventGet(
                          request: GetListProductRequest(
                              page: 1, pageSize: _pageSize)))));
            },
          ),
        ),
      ),
    );
  }
}
