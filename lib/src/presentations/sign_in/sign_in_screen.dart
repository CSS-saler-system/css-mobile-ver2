import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/phone_input_widget.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/presentations/sign_in/components/content_title.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return ScrollViewBase(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContentTitle(),
              const SizedBox(height: 50),
              _buildPhoneInput(),
              const SizedBox(height: 20),
              _buildButton(),
            ]),
      ),
    );
  }

  Widget _buildContentTitle() {
    return const ContentTitle();
  }

  Widget _buildPhoneInput() {
    return const PhoneInputWidget();
  }

  Widget _buildButton() {
    return CustomButton(
      text: "Next",
      onPressed: () => Navigator.pushNamed(context, AppRouters.otpConfirm),
    );
  }
}
