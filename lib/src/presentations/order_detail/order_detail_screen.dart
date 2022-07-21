import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/presentations/main/main_screen.dart';
import 'package:flutter_application_1/src/presentations/order_detail/components/customer_order_info.dart';
import 'package:flutter_application_1/src/presentations/order_detail/components/total_order_info.dart';
import 'package:flutter_application_1/src/resource/response/order_response.dart';

import 'components/product_order_info.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderObject orderData;
  const OrderDetailScreen({Key? key, required this.orderData})
      : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 2,
        backgroundColor: AppColors.primarycolor,
        centerTitle: true,
        title: const Text('Order Detail'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerOrderInfo(orderData: widget.orderData),
              ProductOrderInfo(orderData: widget.orderData),
              TotalOrderInfo(orderData: widget.orderData),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Expanded(
                    //   child: CustomButton(
                    //     text: "Edit Order",
                    //     backgroundColor: Colors.white,
                    //     onPressed: () => Navigator.of(context).pushNamed(
                    //         AppRouters.updateOrderScreen,
                    //         arguments: {"orderData": widget.orderData}),
                    //   ),
                    // ),
                    // const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: "Back to home",
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const MainScreen(pageIndex: 0))),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
