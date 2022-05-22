// error toast
import 'package:flutter/material.dart';

void showErrorToast(BuildContext context, String error) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ),
  );
}
