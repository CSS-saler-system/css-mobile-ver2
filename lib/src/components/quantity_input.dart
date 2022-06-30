import 'package:flutter/material.dart';

class QuantityInput extends StatefulWidget {
  final int quantity;
  final Function(int) onChanged;
  const QuantityInput({Key? key, this.quantity = 1, required this.onChanged})
      : super(key: key);

  @override
  State<QuantityInput> createState() => _QuantityInputState();
}

class _QuantityInputState extends State<QuantityInput> {
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(children: [
        GestureDetector(
          onTap: () {
            setState(() => _quantity == 1 ? 1 : _quantity--);
            widget.onChanged(_quantity);
          },
          child: Container(
            alignment: Alignment.center,
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black),
            ),
            child: const Text("-"),
          ),
        ),
        const SizedBox(width: 10),
        Text("$_quantity"),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() => _quantity++);
            widget.onChanged(_quantity);
          },
          child: Container(
            alignment: Alignment.center,
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black),
            ),
            child: const Text("+"),
          ),
        ),
      ]),
    );
  }
}
