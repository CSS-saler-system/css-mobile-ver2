import 'package:flutter/material.dart';

class ListActionHeader extends StatefulWidget {
  final String? title;
  final VoidCallback? onPressed;
  const ListActionHeader({Key? key, this.onPressed, this.title})
      : super(key: key);

  @override
  State<ListActionHeader> createState() => _ListActionHeaderState();
}

class _ListActionHeaderState extends State<ListActionHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          widget.title ?? "",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              "See all",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
          ),
        )
      ]),
    );
  }
}
