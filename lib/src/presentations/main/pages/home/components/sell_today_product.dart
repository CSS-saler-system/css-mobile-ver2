import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/list_action_hedaer.dart';

import '../../../../../configs/configs.dart';

class SellTodayProducts extends StatefulWidget {
  const SellTodayProducts({Key? key}) : super(key: key);

  @override
  State<SellTodayProducts> createState() => _SellTodayProductsState();
}

class _SellTodayProductsState extends State<SellTodayProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListActionHeader(
          title: "Sell Today",
          onPressed: () {},
        ),
        const SizedBox(height: 20),
        // build grid view products
        Flexible(
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Image.asset(AppImages.iphone12),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Iphone 12",
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "31.000.000 VND",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ]),
                    ));
              }),
        ),
      ]),
    );
  }
}
