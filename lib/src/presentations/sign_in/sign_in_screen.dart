import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/custom_button_widget.dart';
import 'package:flutter_application_1/src/components/dialog_widget.dart';
import 'package:flutter_application_1/src/components/phone_input_widget.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/components/toast_widget.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/otp_confirm/otp_confirm_screen.dart';
import 'package:flutter_application_1/src/presentations/sign_in/components/content_title.dart';
import 'package:flutter_application_1/src/resource/bloc/get_otp_login/login_phone_bloc.dart';
import 'package:flutter_application_1/src/resource/usecase/get_otp_auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../resource/services/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController? _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScrollViewBase(
      appBarColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    return PhoneInputWidget(
      controller: _phoneController,
    );
  }

  Widget _buildButton() {
    return BlocProvider(
      create: (context) => getIt<LoginPhoneBloc>(),
      child: BlocListener<LoginPhoneBloc, LoginPhoneState>(
        listener: (context, state) {
          log(state.toString());
          if (state is GetOtpLoginSuccess) {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpConfirmScreen(
                  verificationId: state.verificationId,
                ),
              ),
            );
          }

          if (state is GetOtpLoginLoading) {
            DialogHelper.onLoading(context);
          }

          if (state is GetOtpLoginFailure) {
            Navigator.pop(context);
            showErrorToast(
                context, "Server has error, please try again later!");
          }
        },
        child: BlocBuilder<LoginPhoneBloc, LoginPhoneState>(
          builder: (context, state) {
            return CustomButton(
              text: "Next",
              // onPressed: () =>
              // Navigator.pushNamed(context, AppRouters.mainScreen),
              onPressed: () {
                BlocProvider.of<LoginPhoneBloc>(context).add(
                    GetOtpLoginButtonPressed(
                        phoneNumber: "+84${_phoneController!.text}"));
              },
            );
          },
        ),
      ),
    );
  }
}
