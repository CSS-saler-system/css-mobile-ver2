import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';
import 'package:flutter_application_1/src/configs/constants/constants.dart';

import '../../../../../components/list_action_hedaer.dart';

class ListBrandWidget extends StatefulWidget {
  const ListBrandWidget({Key? key}) : super(key: key);

  @override
  State<ListBrandWidget> createState() => _ListBrandWidgetState();
}

class _ListBrandWidgetState extends State<ListBrandWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          ListActionHeader(
            title: "Brands",
            onPressed: () =>
                // Navigator.pushNamed(context, AppRouters.listProduct),
                {}
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                      radius: 30, child: Image.asset(AppImages.icApple)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
