import 'package:flutter/material.dart';

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
    return Image.asset(AppImages.bgOtpConfirm);
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
