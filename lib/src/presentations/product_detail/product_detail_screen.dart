import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_gallery.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/components/switch_button_widget.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/full_page_loading/fullpage_loading.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/selling_bloc/selling_bloc_bloc.dart';
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
  final SellingBlocBloc _sellingBloc = getIt<SellingBlocBloc>();

  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    if (widget.productId != null && widget.productId!.isNotEmpty) {
      log(widget.productId!);
      _getProductsBloc.add(GetProductDetailEvent(productId: widget.productId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getProductsBloc,
      child: BlocListener<GetProductsBloc, GetProductsState>(
        listener: (context, state) {
          if (state is GetProductDetailLoaded) {
            log(jsonEncode(state.product));
            state.product.image?.forEach((e) => {
                  if (e.path != null)
                    {
                      setState(() {
                        _images.add(e.path!);
                      })
                    }
                });
          }
        },
        child: BlocBuilder<GetProductsBloc, GetProductsState>(
          builder: (context, state) {
            if (state is GetProductDetailLoaded) {
              return Scaffold(
                body: Stack(children: [
                  CustomGallery(
                    height: MediaQuery.of(context).size.height * .5,
                    images: _images,
                  ),
                  _buildBackButton(),
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
        const SizedBox(height: 10),
        _buildCategory(product),
        const SizedBox(height: 10),
        _buildDescription(product),
        const SizedBox(height: 10),
        _buildShortDescription(product),
        const SizedBox(height: 10),
        _buildDiscount(product),
        const SizedBox(height: 30),
        _buildButtonAction(product)
        // ToggleButton(),
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
            color: AppColors.primarycolor,
          ),
        ),
      ],
    );
  }

  Widget _buildBrandName(ProductData product) {
    return _buildItemRow(title: "Brand", name: product.brand ?? "UNKNOWN");
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.primarycolor.withOpacity(.5),
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.only(top: 50, left: 20),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow({required String title, String? name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const CircleAvatar(
        //   backgroundImage: AssetImage(AppImages.icApple),
        //   radius: 15,
        // ),
        Text("$title:"),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            name ?? "UNKNOWN",
            softWrap: true,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _buildDescription(ProductData product) {
    return _buildItemRow(title: "Description", name: product.description);
  }

  _buildCategory(ProductData product) {
    return _buildItemRow(
        title: "Category", name: product.category?.categoryName);
  }

  _buildShortDescription(ProductData product) {
    return _buildItemRow(
        title: "Short Description", name: product.shortDescription);
  }

  _buildDiscount(ProductData product) {
    return _buildItemRow(
        title: "Point Sale", name: product.pointSale?.toString());
  }

  Widget _buildButtonAction(ProductData product) {
    return BlocProvider(
      create: (context) => _sellingBloc,
      child: BlocListener<SellingBlocBloc, SellingBlocState>(
        listener: (context, state) {
          if (state is CreateSellingLoading) {
            DialogHelper.onLoading(context);
          }

          if (state is CreateSellingError) {
            DialogHelper.hideLoading(context);
            DialogHelper.errorAnimation(context, "Request selling fail!",
                serverMessage: state.failure.message);
          }

          if (state is CreateSellingLoaded) {
            DialogHelper.hideLoading(context);
            DialogHelper.successAnimation(
                context, "Reguest selling successfully!");
          }
        },
        child: Row(children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _sellingBloc
                  .add(CreateSellingEvent(productId: widget.productId ?? "")),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primarycolor,
                ),
                child: const Text("Request",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, AppRouters.createOrderScreen,
                  arguments: {"productId": widget.productId}),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.primarycolor),
                ),
                child: const Text("Order",
                    style: TextStyle(
                        color: AppColors.primarycolor,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
