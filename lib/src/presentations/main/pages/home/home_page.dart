import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/action_header.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/list_brands.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/populars_product.dart';
import 'package:flutter_application_1/src/presentations/main/pages/home/components/sell_today_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(children: [
        const HomeHeaderAction(),
        const SizedBox(height: 20),
        Expanded(
            child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: const [
            ListBrandWidget(),
            SizedBox(height: 20),
            PopularProducts(),
            SizedBox(height: 20),
            Flexible(
              child: SellTodayProducts(),
            )
          ]),
        ))
      ]),
    );
  }
}
