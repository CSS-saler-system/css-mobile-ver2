import 'package:flutter/material.dart';

class CustomTextAreaInput extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final bool textRequired;
  final String? Function(String?)? validation;
  const CustomTextAreaInput({
    Key? key,
    this.controller,
    this.label,
    this.textRequired = false,
    this.validation,
  }) : super(key: key);

  @override
  State<CustomTextAreaInput> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomTextAreaInput> {
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
          validator: widget.validation,
          controller: widget.controller,
          minLines: 2,
          maxLines: 8,
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
