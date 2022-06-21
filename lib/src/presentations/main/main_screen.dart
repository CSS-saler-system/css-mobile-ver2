import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/home_page.dart';
import 'package:flutter_application_1/src/presentations/main/pages/orders/order_page.dart';
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

  // fake menu
  final List<ItemMenu> _items = [
    const ItemMenu(
      icon: Icons.home_outlined,
      index: 0,
    ),
    const ItemMenu(
      icon: Icons.send_outlined,
      index: 1,
      hasAppBar: true,
      title: "Request registration",
    ),
    const ItemMenu(
      icon: Icons.local_grocery_store_outlined,
      index: 2,
      hasAppBar: true,
      title: "My Orders",
    ),
    const ItemMenu(
      icon: Icons.person_outline_outlined,
      index: 3,
    ),
  ];

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    // log("setState" + _pageIndex.toString());
    // if (widget.pageIndex != null) {
    //   _pageIndex = widget.pageIndex!;
    //   onChangePage(_pageIndex);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _items[_pageIndex].hasAppBar
            ? Text(_items[_pageIndex].title ?? "")
            : const SizedBox(),
        centerTitle: true,
        toolbarHeight: _items[_pageIndex].hasAppBar ? kToolbarHeight : 0,
        backgroundColor: _items[_pageIndex].hasAppBar
            ? AppColors.primarycolor
            : Colors.transparent,
        elevation: _items[_pageIndex].hasAppBar ? 1 : 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50, top: 30),
            child: PageView(
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
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigation(
                  items: _items,
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

class ItemMenu {
  final IconData icon;
  final int index;
  final bool hasAppBar;
  final String? title;
  const ItemMenu(
      {Key? key,
      required this.icon,
      required this.index,
      this.hasAppBar = false,
      this.title});
}
