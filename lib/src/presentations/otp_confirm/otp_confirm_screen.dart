import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/otp_confirm/components/content_title.dart';
import 'package:flutter_application_1/src/presentations/otp_confirm/components/pin_code_input.dart';
import 'package:flutter_application_1/src/resource/usecase/verify_otp_login.dart';

class OtpConfirmScreen extends StatefulWidget {
  final String verificationId;
  const OtpConfirmScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<OtpConfirmScreen> createState() => _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends State<OtpConfirmScreen> {
  final VerifyOtpPhoneLogin _verifyOtpPhoneLogin = getIt<VerifyOtpPhoneLogin>();

  @override
  Widget build(BuildContext context) {
    return ScrollViewBase(
      body: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildContentTitle(),
              const SizedBox(height: 20),
              _buildPinCodeInput(),
            ],
          )),
    );
  }

  Widget _buildContentTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ContentTitle(),
    );
  }

  Widget _buildPinCodeInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PinCodeInput(
        onCompleted: (value) => _verifyOtpPhoneLogin.execute(
            VerifyOtpPhoneLoginInput(widget.verificationId, value ?? "")),
      ),
    );
  }
}
