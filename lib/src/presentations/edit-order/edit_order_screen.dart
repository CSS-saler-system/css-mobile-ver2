import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/order_info.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/product_list.dart';
import 'package:flutter_application_1/src/resource/bloc/get_products/get_products_bloc.dart';
import 'package:flutter_application_1/src/resource/bloc/order_bloc/order_bloc.dart';
import 'package:flutter_application_1/src/resource/response/customer_response.dart';
import 'package:flutter_application_1/src/resource/response/order_response.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';

class EditOrderScreen extends StatefulWidget {
  final OrderObject orderData;
  const EditOrderScreen({Key? key, required this.orderData}) : super(key: key);

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  int _quantity = 1;
  final GetProductsBloc _getProductsBloc = getIt<GetProductsBloc>();
  final OrderBloc _orderBloc = getIt<OrderBloc>();
  late ProductData _productData;
  final _phoneNumber = TextEditingController(),
      _address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _customerId = "";
  late CustomerData initCustomer;

  @override
  void initState() {
    super.initState();

    setState(() {
      _phoneNumber.text = widget.orderData.deliveryPhone ?? "";
      _address.text = widget.orderData.deliveryAddress ?? "";
      _customerId = widget.orderData.customer?.id ?? "";
      _productData = ProductData(
          id: widget.orderData.orderDetails?[0].id ?? "",
          name: widget.orderData.orderDetails?[0].nameProduct ?? "UNKNOW",
          price: widget.orderData.orderDetails?[0].productPrice ?? 0,
          // pointSale: widget.orderData.orderDetails?[0].
          pointSale: 0,
          quantity: widget.orderData.orderDetails?[0].quantity ?? 1);

      initCustomer = CustomerData(
        id: widget.orderData.customer?.id,
        name: widget.orderData.customer?.name,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollViewBase(
      title: "Edit Order",
      backButton: true,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Product Info",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textcolor,
            ),
          ),
          const SizedBox(height: 10),
          ProductList(
              product: _productData,
              quantity: _quantity,
              onChanged: (quantity) => setState(() => _quantity = quantity)),
          const Divider(),
          const Text(
            "Order Infomation",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textcolor,
            ),
          ),
          OrderInfo(
            initCustomer: initCustomer,
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
                if (_customerId.isEmpty) {
                  DialogHelper.errorAnimation(
                      context, "Please select customer!");
                } else {
                  _orderBloc.add(
                    CreateOrderEvent(
                      productId: widget.orderData.orderDetails![0].id!,
                      customerId: _customerId,
                      phoneNumber: _phoneNumber.text,
                      address: _address.text,
                      quantity: _quantity,
                      productOrder: [],
                    ),
                  );
                }
              }
            },
            text: "Update Order",
          )
        ]),
      ),
    );
  }
}
