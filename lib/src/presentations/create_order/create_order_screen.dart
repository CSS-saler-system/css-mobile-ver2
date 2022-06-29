import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/order_info.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/product_list.dart';
import 'package:flutter_application_1/src/presentations/full_page_loading_2/fullpage_loading_v2.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/order_bloc/order_bloc.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderScreen extends StatefulWidget {
  final String productId;
  const CreateOrderScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  int _quantity = 1;
  final GetProductsBloc _getProductsBloc = getIt<GetProductsBloc>();
  final OrderBloc _orderBloc = getIt<OrderBloc>();
  late ProductData _productData;
  final _phoneNumber = TextEditingController(),
      _address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _customerId = "";

  @override
  void initState() {
    super.initState();
    _getProductsBloc.add(GetProductDetailEvent(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _getProductsBloc,
        ),
        BlocProvider(
          create: (context) => _orderBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<GetProductsBloc, GetProductsState>(
            listener: (context, state) {
              if (state is GetProductDetailLoaded) {
                _productData = state.product;
              }

              if (state is GetProductDetailError) {
                DialogHelper.errorAnimation(
                  context,
                  "Not found product!",
                  routerName: AppRouters.productDetail,
                  args: {
                    "productId": widget.productId,
                  },
                );
              }
            },
          ),
          BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is CreateOrderLoading) {
                DialogHelper.onLoading(context);
              }

              if (state is CreateOrderLoaded) {
                DialogHelper.hideLoading(context);
                DialogHelper.successAnimation(
                  context,
                  "Create Order is successfull!",
                  lotieFile: AppLotties.orderSuccess,
                  routerName: AppRouters.mainScreen,
                );
              }

              if (state is CreateOrderError) {
                DialogHelper.errorAnimation(
                  context,
                  "Create order is fail, Please try again!",
                  serverMessage: state.failure.message,
                );
              }
            },
          ),
        ],
        child: BlocBuilder<GetProductsBloc, GetProductsState>(
          builder: (context, state) {
            if (state is GetProductDetailLoaded) {
              return ScrollViewBase(
                title: "New Order",
                backButton: true,
                body: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Product Info",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ProductList(
                            product: _productData,
                            quantity: _quantity,
                            onChanged: (quantity) =>
                                setState(() => _quantity = quantity)),
                        const Divider(),
                        const Text(
                          "Order Infomation",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        OrderInfo(
                          addressController: _address,
                          phoneNumberControler: _phoneNumber,
                          selectCustomer: (customerId) {
                            setState(() => _customerId = customerId);
                            log(customerId);
                          },
                          formKey: _formKey,
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_customerId.isEmpty) {
                                DialogHelper.errorAnimation(
                                  context,
                                  "Please select customer!",
                                );
                              } else {
                                _orderBloc.add(
                                  CreateOrderEvent(
                                    productId: widget.productId,
                                    customerId: _customerId,
                                    phoneNumber: _phoneNumber.text,
                                    address: _address.text,
                                    quantity: _quantity,
                                  ),
                                );
                              }
                            }
                          },
                          text: "Create Order",
                        )
                      ]),
                ),
              );
            } else if (state is GetProductDetailLoading) {
              return const FullPageLoadingV2(
                  lottie: AppLotties.productLoading,
                  message: "Loading product information, please wait");
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
