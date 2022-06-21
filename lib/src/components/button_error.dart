import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';

class ButtonError extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonError({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        "Something went wrong",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primarycolor),
        ),
        onPressed: onPressed,
        child: const Text(
          "Try again",
          style: TextStyle(color: Colors.white),
        ),
      )
    ]);
  }
}
