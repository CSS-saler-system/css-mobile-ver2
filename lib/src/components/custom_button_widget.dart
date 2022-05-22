import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  const CustomButton(
      {Key? key, this.onPressed, required this.text, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shadowColor: MaterialStateProperty.all<Color>(Colors.black),
          elevation: MaterialStateProperty.all<double>(3),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 15)),
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? Colors.orange,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
