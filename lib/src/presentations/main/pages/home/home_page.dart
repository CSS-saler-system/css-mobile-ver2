import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/button_error.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/action_header.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/campings.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/list_brands.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/populars_product.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/sell_today_product.dart';
import 'package:flutter_application_1/src/resource/bloc/enteprise_bloc/enteprise_bloc.dart';
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
  final EntepriseBloc _entepriseBloc = getIt<EntepriseBloc>();
  final List<ProductData> productSell = [];
  bool _loadMore = false;
  int _page = 1, _pageSize = 8, _totalPage = 0;

  @override
  void initState() {
    super.initState();
    _entepriseBloc.add(GetListEntepriseEvent());
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
            _buildEntepriseList(),
            const SizedBox(height: 10),
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
              productSell.clear();
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

  Widget _buildEntepriseList() {
    return BlocProvider(
      create: (context) => _entepriseBloc,
      child: Flexible(
        child: BlocBuilder<EntepriseBloc, EntepriseState>(
          builder: (context, state) {
            log(state.toString());
            if (state is GetListEntepriseLoadding) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetListEntepriseLoaded) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Enteprise",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textcolor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            "See all",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primarycolor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: state.enteprises.map((e) {
                      log(e.idCard!.path!);
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, AppRouters.listProduct,
                            arguments: {"title": e.name, "id": e.id}),
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: 80,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: e.idCard != null &&
                                          e.idCard!.path != null &&
                                          e.idCard!.path!.isNotEmpty
                                      ? Image.network(
                                          e.idCard!.path!,
                                          fit: BoxFit.fitHeight,
                                        )
                                      : Image.asset(
                                          AppImages.iphone12,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Name: ${e.name!}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "Description: ${e.description!}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "Date: ${e.dob!}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }

            return Center(
                child: ButtonError(
                    onPressed: () =>
                        _entepriseBloc.add(GetListEntepriseEvent())));
          },
        ),
      ),
    );
  }
}
