import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/button_error.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/main/pages/orders/components/order_item.dart';
import 'package:flutter_application_1/src/resource/bloc/order_bloc/order_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resource/response/order_response.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderBloc _orderBloc = getIt<OrderBloc>();

  @override
  void initState() {
    super.initState();

    _orderBloc.add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _orderBloc,
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is GetOrdersLoaded) {
              final orders = state.orders.data ?? [];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      OrderObject order = orders[index];
                      return OrderItem(order: order);
                    }),
              );
            } else if (state is GetOrdersFail) {
              return ButtonError(onPressed: () {});
            } else if (state is GetOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
