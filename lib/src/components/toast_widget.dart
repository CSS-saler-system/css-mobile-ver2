// error toast
import 'package:flutter/material.dart';

void showErrorToast(BuildContext context, String error) {
  // Scaffold.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(error),
  //     backgroundColor: Colors.red,
  //   ),
  // );
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Error"),
      content: Text(error),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
