import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/configs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, AppRouters.signIn),
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
