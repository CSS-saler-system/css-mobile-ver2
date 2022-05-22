import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/switch_button_widget.dart';

import '../../configs/configs.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? productId;
  const ProductDetailScreen({Key? key, this.productId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: .9,
            builder: (context, controller) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ]),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20),
                  controller: controller,
                  child: _buildDetailProduct(),
                ),
              );
            })
      ]),
    );
  }

  Widget _buildDetailProduct() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _buildProductName(),
        const SizedBox(height: 20),
        _buildBrandName(),
        const SizedBox(height: 20),
        ToggleButton(),
      ]),
    );
  }

  Widget _buildProductName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Iphone 12",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "31.000.000 VND",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildBrandName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircleAvatar(
          backgroundImage: AssetImage(AppImages.icApple),
          radius: 15,
        ),
        SizedBox(width: 10),
        Text(
          "Apple",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
