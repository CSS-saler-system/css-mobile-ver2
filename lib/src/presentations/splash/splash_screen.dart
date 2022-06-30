import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/configs.dart';
import 'package:flutter_application_1/src/configs/di/injection.dart';
import 'package:flutter_application_1/src/presentations/main/main_screen.dart';
import 'package:flutter_application_1/src/resource/repository/local_reponsitory.dart';
import 'package:flutter_application_1/src/resource/response/login_response.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalRepository _localRepository = getIt<LocalRepository>();

  @override
  void initState() {
    super.initState();
    _getLoginInfo();
  }

  Future<void> _getLoginInfo() async {
    LoginResponse? loginInfo = await _localRepository.getLoginInfo();
    Timer(
      const Duration(seconds: 3),
      () {
        if (loginInfo != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => MainScreen(pageIndex: 0)));
        } else {
          Navigator.pushReplacementNamed(context, AppRouters.signIn);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImage(),
            _buildLoading(),
          ]),
    );
  }

  Widget _buildImage() {
    return Image.asset(AppImages.appLogo);
  }

  Widget _buildLoading() {
    return Container();
  }
}
