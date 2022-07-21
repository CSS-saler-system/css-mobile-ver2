import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/order_info.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/product_info.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/product_list.dart';
import 'package:flutter_application_1/src/presentations/full_page_loading_2/fullpage_loading_v2.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/order_bloc/order_bloc.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/resource/extension/number.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final OrderBloc _orderBloc = getIt<OrderBloc>();
  final _phoneNumber = TextEditingController(),
      _address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _customerId = "";
  List<ProductOrder> _productOrders = [];
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _orderBloc,
        child: BlocListener<OrderBloc, OrderState>(
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
                args: {"pageIndex": 2},
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
          child: ScrollViewBase(
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
                    ProductInfo(productOrder: (orderProducts) {
                      totalPrice = 0;
                      setState(() {
                        _productOrders = orderProducts;
                        _productOrders.forEach((element) {
                          log(element.orderQuantiry.toString());
                          log(element.price.toString());
                          totalPrice += element.orderQuantiry * element.price!;
                          log(totalPrice.toString());
                        });
                      });
                    }),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        totalPrice.getVnCurrence,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ]),
                    const SizedBox(height: 30),
                    const Divider(),
                    const Text(
                      "Order Infomation",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    OrderInfo(
                      addressController: _address,
                      phoneNumberControler: _phoneNumber,
                      selectCustomer: (customerId) {
                        setState(() => _customerId = customerId);
                      },
                      formKey: _formKey,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_productOrders.isEmpty) {
                            DialogHelper.errorAnimation(
                                context, "Please select products!");
                          }
                          if (_customerId.isEmpty) {
                            DialogHelper.errorAnimation(
                                context, "Please select customer!");
                          } else {
                            _orderBloc.add(
                              CreateOrderEvent(
                                productId: "",
                                customerId: _customerId,
                                phoneNumber: _phoneNumber.text,
                                address: _address.text,
                                quantity: 1,
                                productOrder: _productOrders,
                              ),
                            );
                          }
                        }
                      },
                      text: "Create Order",
                    )
                  ]),
            ),
          ),
        ));
  }
}
