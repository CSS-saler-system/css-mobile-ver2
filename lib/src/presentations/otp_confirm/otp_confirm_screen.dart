import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/components/srceen_scrollview.dart';
import 'package:flutter_application_1/src/components/toast_widget.dart';
import 'package:flutter_application_1/src/configs/constants/app_router.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/otp_confirm/components/content_title.dart';
import 'package:flutter_application_1/src/presentations/otp_confirm/components/pin_code_input.dart';
import 'package:flutter_application_1/src/resource/bloc/get_otp_login/login_phone_bloc.dart';
import 'package:flutter_application_1/src/resource/usecase/verify_otp_login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    appBarColor: Colors.transparent,
      body: BlocProvider<LoginPhoneBloc>(
        create: (_) => getIt<LoginPhoneBloc>(),
        child: Container(
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
      ),
    );
  }

  Widget _buildContentTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ContentTitle(),
    );
  }

  Widget _buildPinCodeInput() {
    return BlocListener<LoginPhoneBloc, LoginPhoneState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          Navigator.of(context).pushReplacementNamed(AppRouters.mainScreen);
        }

        if (state is VerifyOtpFailure) {
          showErrorToast(context, state.error);
        }
      },
      child: BlocBuilder<LoginPhoneBloc, LoginPhoneState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PinCodeInput(
              onCompleted: (value) async {
                BlocProvider.of<LoginPhoneBloc>(context).add(
                    VerifyOtpLoginButtonPressed(
                        verificationId: widget.verificationId,
                        otp: value ?? ""));
                // bool result = await _verifyOtpPhoneLogin.execute(
                //     VerifyOtpPhoneLoginInput(widget.verificationId, value ?? ""));
                // log("result: $result");
              },
            ),
          );
        },
      ),
    );
  }
}
