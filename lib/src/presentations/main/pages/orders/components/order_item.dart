import 'package:flutter/material.dart';

import '../../../../../configs/configs.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRouters.orderDetail),
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
    );
  }

  Widget _buildCardHeader() {
    return Container(
      child: Row(children: const [
        // ORDER ID
        Text(
          "#123456789",
          style: TextStyle(fontSize: 12),
        ),
        // ORDER DATETIME
        Expanded(
          child: Text(
            "2020/01/01",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ]),
    );
  }

  Widget _buildCardBody() {
    return Container(
      child: Row(children: [
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
                  "Tran Hoang Huy".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Discount: 30\$",
                  style: TextStyle(fontSize: 13),
                ),
                const Text(
                  "Total: 50\$",
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildCardFooter() {
    return const Text("Status: Pending",
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
  }
}
