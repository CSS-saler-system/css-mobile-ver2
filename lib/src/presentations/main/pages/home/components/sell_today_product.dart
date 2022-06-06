import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/list_action_hedaer.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';

import '../../../../../configs/configs.dart';
import '../../../../../resource/extension/number.dart';

class SellTodayProducts extends StatefulWidget {
  final List<ProductData> products;
  const SellTodayProducts({Key? key, required this.products}) : super(key: key);

  @override
  State<SellTodayProducts> createState() => _SellTodayProductsState();
}

class _SellTodayProductsState extends State<SellTodayProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListActionHeader(
        title: "Sell Today",
        onPressed: () {},
      ),
      const SizedBox(height: 20),
      // build grid view products
      Flexible(
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: widget.products.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRouters.productDetail,
                      arguments: {"productId": widget.products[index].id});
                },
                child: Card(
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
                              child: widget.products[index].image!.length <= 0
                                  ? Image.asset(AppImages.iphone12)
                                  : Image.network(
                                      widget.products[index].image![0].path ??
                                          ""),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.products[index].name ?? "",
                              maxLines: 1,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.products[index].price!.getVnCurrence,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ]),
                    )),
              );
            }),
      ),
    ]);
  }
}
