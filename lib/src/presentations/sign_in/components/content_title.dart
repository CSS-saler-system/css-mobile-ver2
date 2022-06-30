import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/configs.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:lottie/lottie.dart';

class ContentTitle extends StatelessWidget {
  const ContentTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        _buildTextDescription(),
      ],
    );
  }

  Widget _buildImage() {
    return Lottie.asset(AppLotties.getOtp);
  }

  Widget _buildTextDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Text(
        "Enter the phone number associated with your account",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textcolor,
        ),
      ),
    );
  }
}
