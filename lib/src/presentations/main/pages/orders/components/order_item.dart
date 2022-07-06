import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/resource/bloc/order_bloc/order_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../configs/configs.dart';
import '../../../../../resource/response/order_response.dart';
import '../../../../../resource/extension/number.dart';

class OrderItem extends StatelessWidget {
  final OrderObject order;
  OrderItem({Key? key, required this.order}) : super(key: key);

  final OrderBloc _orderBloc = getIt<OrderBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _orderBloc,
        child: order.orderDetails!.isNotEmpty
            ? GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, AppRouters.orderDetail),
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCardHeader(),
                              const Divider(),
                              _buildCardBody(),
                              const Divider(),
                              _buildCardFooter(),
                            ]),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox());
  }

  Widget _buildCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // ORDER DATETIME
        const Icon(Icons.calendar_today_outlined, size: 15),
        const SizedBox(width: 5),
        Text(
          "${order.createDate}",
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCardBody() {
    return Row(children: [
      // ORDER IMAGE
      Container(
        height: 80,
        width: 80,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.iphone12),
            fit: BoxFit.cover,
          ),
        ),
      ),

      // ORDER SHORT DESCRIPTION
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${order.orderDetails![0].nameProduct}".toUpperCase(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "Discount: ${order.totalPointSale?.getVnCurrence}",
                style: const TextStyle(fontSize: 13),
              ),
              Text(
                "Total: ${order.totalPrice?.getVnCurrence}",
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildCardFooter() {
    return Text(
      "Status: ${order.status}",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: order.status == "DISABLE" ? Colors.grey : Colors.red,
      ),
    );
  }
}
