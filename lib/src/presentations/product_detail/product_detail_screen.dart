import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/switch_button_widget.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/full_page_loading/fullpage_loading.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/resource/extension/number.dart';
import '../../configs/configs.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? productId;
  const ProductDetailScreen({Key? key, this.productId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GetProductsBloc _getProductsBloc = getIt<GetProductsBloc>();

  @override
  void initState() {
    super.initState();

    if (widget.productId != null && widget.productId!.isNotEmpty) {
      _getProductsBloc.add(GetProductDetailEvent(productId: widget.productId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getProductsBloc,
      child: BlocBuilder<GetProductsBloc, GetProductsState>(
        builder: (context, state) {
          if (state is GetProductDetailLoaded) {
            return Scaffold(
              body: Stack(children: [
                DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    minChildSize: 0.5,
                    maxChildSize: .9,
                    builder: (context, controller) {
                      return Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                            ]),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 20),
                          controller: controller,
                          child: _buildDetailProduct(state.product),
                        ),
                      );
                    })
              ]),
            );
          }

          return const FullPageLoading();
        },
      ),
    );
  }

  Widget _buildDetailProduct(ProductData product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildProductName(product),
        const SizedBox(height: 20),
        _buildBrandName(product),
        const SizedBox(height: 20),
        ToggleButton(),
      ]),
    );
  }

  Widget _buildProductName(ProductData product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product.name ?? "UNKNOWN",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          product.price!.getVnCurrence,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildBrandName(ProductData product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(AppImages.icApple),
          radius: 15,
        ),
        const SizedBox(width: 10),
        Text(
          product.brand ?? "UNKNOWN",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
