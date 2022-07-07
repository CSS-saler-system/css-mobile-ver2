import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resource/response/order_response.dart';
import '../../../resource/extension/number.dart';

class TotalOrderInfo extends StatelessWidget {
  final OrderObject orderData;
  const TotalOrderInfo({Key? key, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 1, // changes position of shadow
        ),
      ]),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "#Bill Information",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildItemBill(
                title: "Discount",
                value:
                    orderData.totalPointSale?.getVnCurrence.toString() ?? ""),
            _buildItemBill(
                title: "Total Price",
                value: orderData.totalPrice!.getVnCurrence.toString()),
            // _buildItemBill(title: "Total Paid", value: "1,000,000 VND"),
          ],
        ),
      ),
    );
  }

  Widget _buildItemBill({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
