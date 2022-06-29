import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/button_error.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/request/get_list_product_request.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../resource/extension/number.dart';
import '../../configs/configs.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({Key? key}) : super(key: key);

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final ScrollController _scrollController = ScrollController();
  final GetProductsBloc _getProductsBloc = getIt<GetProductsBloc>();
  final searchController = TextEditingController();
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
        }
      }
    });

    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        _getProductsBloc.add(
          GetProductsEventGet(
            request: GetListProductRequest(
              page: 1,
              pageSize: _pageSize,
              productName: searchController.text,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 2,
        backgroundColor: AppColors.primarycolor,
        centerTitle: true,
        title: const Text(
          'List Products',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => _getProductsBloc,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(children: [
              TextField(
                autofocus: false,
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
              Expanded(
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
                        return const Center(
                            child: SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator()));
                      } else if (state is GetProductsLoaded) {
                        return GridView.builder(
                            itemCount: productSell.length,
                            // controller: _scrollController,
                            // physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                itemCard(productSell[index]));
                      }
                      return Center(
                        child: ButtonError(onPressed: () {}),
                      );
                    },
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget itemCard(ProductData product) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRouters.productDetail,
          arguments: {"productId": product.id}),
      child: Card(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.only(right: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: product.image != null && product.image!.isNotEmpty
                        ? Image.network(product.image![0].path ?? "")
                        : Image.asset(AppImages.iphone12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.name ?? "Unknown",
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.price!.getVnCurrence,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primarycolor,
                    ),
                  ),
                ]),
          )),
    );
  }
}
