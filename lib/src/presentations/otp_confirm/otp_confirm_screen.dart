import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/presentations/otp_confirm/components/content_title.dart';
import 'package:flutter_application_1/src/presentations/otp_confirm/components/pin_code_input.dart';

class OtpConfirmScreen extends StatefulWidget {
  const OtpConfirmScreen({Key? key}) : super(key: key);

  @override
  State<OtpConfirmScreen> createState() => _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends State<OtpConfirmScreen> {
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: PinCodeInput(),
    );
  }
}
