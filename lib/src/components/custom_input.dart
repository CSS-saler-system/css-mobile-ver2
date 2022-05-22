import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final bool textRequired;
  const CustomInputWidget(
      {Key? key, this.controller, this.label, this.textRequired = false})
      : super(key: key);

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          widget.label != null && widget.label!.isNotEmpty
              ? Text(
                  widget.label ?? "",
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                )
              : const SizedBox(),
          // required
          widget.textRequired
              ? const Text("*", style: TextStyle(color: Colors.red))
              : const SizedBox(),
        ],
      ),
      widget.label != null ? const SizedBox(height: 5) : const SizedBox(),
      Material(
        elevation: 3,
        shadowColor: Colors.black12,
        child: TextFormField(
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
            labelText: "",
            filled: true,
            fillColor: Colors.white,
          ),
          style: const TextStyle(fontSize: 15),
        ),
      ),
    ]);
  }
}
