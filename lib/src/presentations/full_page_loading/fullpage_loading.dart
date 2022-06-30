import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';

class FullPageLoading extends StatelessWidget {
  const FullPageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.appLogo),
          const SizedBox(height: 20),
          const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(color: AppColors.primarycolor)),
        ],
      ),
    );
  }
}
