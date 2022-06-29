import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/quantity_input.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';
import 'package:flutter_application_1/src/resource/response/product_response.dart';
import '../../../resource/extension/number.dart';

class ProductList extends StatefulWidget {
  final int quantity;
  final Function(int) onChanged;
  final ProductData product;
  const ProductList(
      {Key? key,
      required this.quantity,
      required this.onChanged,
      required this.product})
      : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int? _quantity = 0;
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
    _totalPrice = widget.quantity * widget.product.price!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(children: [
            // ORDER IMAGE
            Container(
              height: 80,
              width: 80,
              child: widget.product.image!.isEmpty
                  ? Image.asset(
                      AppImages.iphone12,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      widget.product.image![0].path!,
                      fit: BoxFit.cover,
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
                      widget.product.name!.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Price: " + widget.product.price!.getVnCurrence,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 5),
                    QuantityInput(
                        quantity: 1,
                        // onChanged: widget.onChanged,
                        onChanged: (quantity) {
                          setState(() {
                            _totalPrice = quantity * widget.product.price!;
                          });
                        }),
                  ],
                ),
              ),
            ),
          ]),
        ),
        const Divider(),
        Container(
          alignment: Alignment.centerRight,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Total Pirce: ${_totalPrice.getVnCurrence}"),
              ]),
        ),
      ],
    );
  }
}
