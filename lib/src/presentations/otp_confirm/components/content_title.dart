import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_lotties.dart';
import 'package:lottie/lottie.dart';

import '../../../configs/configs.dart';

class ContentTitle extends StatelessWidget {
  const ContentTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextTitle(),
        _buildImage(),
      ],
    );
  }

  Widget _buildImage() {
    return Lottie.asset(AppLotties.confitmOtp);
  }

  Widget _buildTextTitle() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Text("OTP Verification",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )));
  }
}
