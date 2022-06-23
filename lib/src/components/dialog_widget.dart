import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:lottie/lottie.dart';

class DialogHelper {
  static void onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  AppLotties.loading,
                  width: MediaQuery.of(context).size.width * 0.5,
                  repeat: true,
                  reverse: true,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Loading...",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void onError(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.error),
                    SizedBox(width: 10),
                    Text("Error"),
                  ],
                ),
                const SizedBox(height: 10),
                Text(message),
                const SizedBox(height: 10),
                RaisedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void errorAnimation(BuildContext context, String message,
      {String? serverMessage}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  AppLotties.error,
                  width: MediaQuery.of(context).size.width * 0.5,
                  repeat: true,
                  reverse: true,
                ),
                const SizedBox(height: 30),
                Text(
                  message,
                  style: const TextStyle(color: Colors.black),
                ),
                serverMessage != null
                    ? const SizedBox(height: 10)
                    : const SizedBox.shrink(),
                Text(
                  serverMessage ?? "",
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void successAnimation(BuildContext context, String message,
      {String? routerName}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  AppLotties.success,
                  width: MediaQuery.of(context).size.width * 0.5,
                  repeat: true,
                  reverse: true,
                ),
                const SizedBox(height: 30),
                Text(
                  message,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                    if (routerName != null && routerName.isNotEmpty) {
                      Navigator.pushReplacementNamed(context, routerName);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
