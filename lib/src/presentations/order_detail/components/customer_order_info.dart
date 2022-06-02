import 'package:flutter/material.dart';

class CustomerOrderInfo extends StatelessWidget {
  const CustomerOrderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            // STATUS
            const SizedBox(height: 10),
            Row(
              children: const [
                Text(
                  'Status: ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Pending',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "#123456789",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "2020/01/01",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text("#Customer Order Information",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            _personalItem(title: "customer name", value: "Tran Hoang Huy"),
            _personalItem(title: "email", value: "fxhuytran99@gmail.com"),
            _personalItem(title: "phone", value: "0987654321"),
          ],
        ),
      ),
    );
  }

  Widget _personalItem({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
