import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:lottie/lottie.dart';

class DialogHelper {
  static void onLoading(BuildContext context,
      {String? lottie, String? message}) {
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
                Text(
                  message ?? "Loading...",
                  style: const TextStyle(color: Colors.black),
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
                MaterialButton(
                    child: const Text("OK"),
                    onPressed: () => Navigator.pop(context))
              ],
            ),
          ),
        );
      },
    );
  }

  static void errorAnimation(BuildContext context, String message,
      {String? serverMessage, String? routerName, dynamic args}) {
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
                  textAlign: TextAlign.center,
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
                    if (routerName != null && routerName.isNotEmpty) {
                      Navigator.pushReplacementNamed(context, routerName,
                          arguments: args);
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

  static void successAnimation(BuildContext context, String message,
      {String? routerName, String? lotieFile, dynamic args}) {
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
                  lotieFile ?? AppLotties.success,
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
                      Navigator.pushReplacementNamed(context, routerName,
                          arguments: args);
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

  static void dialogConfirm(BuildContext context,
      {String? lotieFile,
      required String message,
      required VoidCallback onpressed}) {
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
                  lotieFile ?? AppLotties.success,
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
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Text("CANCEL"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primarycolor),
                        ),
                        child: const Text("OK",
                            style: TextStyle(color: Colors.white)),
                        onPressed: onpressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
