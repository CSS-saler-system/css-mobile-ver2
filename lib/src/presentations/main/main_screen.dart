import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/home_page.dart';
import 'package:flutter_application_1/src/presentations/main/pages/order_page.dart';
import 'package:flutter_application_1/src/presentations/main/pages/profile/profile_page.dart';
import 'package:flutter_application_1/src/presentations/main/pages/request/request_page.dart';

import 'components/bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  final int? pageIndex;
  const MainScreen({Key? key, this.pageIndex}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Stack(children: [
          PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              controller: _pageController,
              children: const [
                HomePage(),
                RequestPage(),
                OrderPage(),
                ProfilePage(),
              ]),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigation(
                  pageIndex: _pageIndex,
                  itemMenuClicked: (page) => onChangePage(page)))
        ]),
      ),
    );
  }

  void onChangePage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
  }
}
