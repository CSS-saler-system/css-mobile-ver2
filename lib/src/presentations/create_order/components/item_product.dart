import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/src/components/quantity_input.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';
import 'package:flutter_application_1/src/presentations/create_order/components/product_info.dart';
import '../../../resource/extension/number.dart';

class ItemProductOrder extends StatefulWidget {
  final ProductOrder product;
  final Function(int) onChange;
  const ItemProductOrder(
      {Key? key, required this.product, required this.onChange})
      : super(key: key);

  @override
  State<ItemProductOrder> createState() => _ItemProductOrderState();
}

class _ItemProductOrderState extends State<ItemProductOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        // ORDER IMAGE
        SizedBox(
          height: 80,
          width: 80,
          child: widget.product.image == null ||
                  widget.product.image != null && widget.product.image!.isEmpty
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
                  widget.product.name.toUpperCase(),
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
                    onChanged: (quantity) {
                      widget.onChange(quantity);
                    }),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
