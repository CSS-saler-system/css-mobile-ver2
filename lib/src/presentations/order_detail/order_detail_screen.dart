import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/presentations/order_detail/components/customer_order_info.dart';
import 'package:flutter_application_1/src/presentations/order_detail/components/total_order_info.dart';

import 'components/product_order_info.dart';

class OrderDetailScreen extends StatefulWidget {
  final int? orderId;
  const OrderDetailScreen({Key? key, this.orderId}) : super(key: key);

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
            children: const [
              CustomerOrderInfo(),
              ProductOrderInfo(),
              TotalOrderInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
