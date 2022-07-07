import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resource/response/order_response.dart';
import '../../../resource/extension/number.dart';

class ProductOrderInfo extends StatelessWidget {
  final OrderObject orderData;
  const ProductOrderInfo({Key? key, required this.orderData}) : super(key: key);

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
              "#Product Information",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: orderData.orderDetails!
                  .map((e) => _itemProductInfo(
                      productName: e.nameProduct ?? "UNKNOW",
                      quantity: e.quantity?.toInt() ?? 0,
                      price: e.productPrice!.getVnCurrence.toString()))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemProductInfo(
      {required String productName,
      required int quantity,
      required String price}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(children: <InlineSpan>[
            TextSpan(
                text: productName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            WidgetSpan(
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text('x$quantity',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ),
            ),
          ])),
          Text(
            price,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
